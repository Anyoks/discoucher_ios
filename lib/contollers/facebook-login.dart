import 'dart:async';
import 'dart:convert';
import 'package:discoucher/contollers/auth-controller.dart';
import 'package:http/http.dart' as http;

import 'package:discoucher/models/facebook-user.dart';
import 'package:discoucher/models/shared.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookLoginController extends AuthController {
  final String grapghUrl =
      "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=";
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<LoginResults> loginToFacebook() async {
    LoginResults logInAttempt = new LoginResults();

    final FacebookLoginResult result =
        await facebookSignIn.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        logInAttempt = await fetchFacebookUser(result);
        break;
      case FacebookLoginStatus.cancelledByUser:
        logInAttempt.message = "Login was canceled";
        break;
      case FacebookLoginStatus.error:
        logInAttempt.message = "Error: Unable to login at the moment";
        break;
    }

    return logInAttempt;
  }

  Future<LoginResults> fetchFacebookUser(
      FacebookLoginResult loginResults) async {
    final FacebookAccessToken accessToken = loginResults.accessToken;
    try {
      var graphResponse =
          await http.get(Uri.encodeFull(grapghUrl + accessToken.token));

      final picUri = new Uri.https(
          "graph.facebook.com",
          'v3.1/100028213101190/picture',
          {"type": "large", "access_token": accessToken.token});
      var picRes = await http.get(picUri);

      var profileData = json.decode(graphResponse.body);
      var userProfile = FacebookProfile.fromJson(profileData);
      userProfile.bytes = picRes.bodyBytes;

      return new LoginResults(
          success: true,
          profile: userProfile,
          message: "Logged in successfully",
          token: accessToken);
    } catch (e) {
      return new LoginResults(
          success: false,
          message:
              "Log in was successful, but we could not fetch the user profle");
    }
  }

  Future<bool> logOutFacebook() async {
    try {
      await facebookSignIn.logOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> attemptFacebookLogin() async {
    try {
      LoginResults results = await loginToFacebook();
      if (results.success) {
        FacebookAccessToken token = results.token;
        FacebookProfile profile = results.profile;

        LoggedInUser loggedinUSer = LoggedInUser(
          id: profile.id,
          email: profile.email,
          fullName: profile.name,
          photoUrl: profile.picture.data.url,
          bytes: profile.bytes,
          token: token.token,
        );

        await saveLoggedInUser(loggedinUSer);
        return true;
      } else {
        return false;
      }
    } catch (errorMessage) {
      return false;
    }
  }
}
