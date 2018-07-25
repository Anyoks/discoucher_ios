import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:discoucher/models/facebook-user.dart';
import 'package:discoucher/models/shared.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookLoginController {
  final String grapghUrl =
      "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=";
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<LoginResults> login() async {
    LoginResults logInAttempt = new LoginResults();

    final FacebookLoginResult result =
        await facebookSignIn.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        logInAttempt = await fetchFacebookUser(result);
        logInAttempt.message = "Login successful";
        logInAttempt.token = accessToken;
        break;
      case FacebookLoginStatus.cancelledByUser:
        logInAttempt.message = "Login was canceled";
        break;
      case FacebookLoginStatus.error:
        logInAttempt.message =
            "Unable to login at the moment, please check your network and try again";
        break;
    }

    return logInAttempt;
  }

  Future<LoginResults> fetchFacebookUser(FacebookLoginResult loginResults) async {
    final FacebookAccessToken accessToken = loginResults.accessToken;
    try {
      var graphResponse =
          await http.get(Uri.encodeFull(grapghUrl + accessToken.token));
      var profile = json.decode(graphResponse.body);

      return new LoginResults(
          success: true,
          profile: FacebookProfile.fromJson(profile),
          message: "User profile was fetched successfully");
    } catch (e) {
      return new LoginResults(
          success: false,
          message: "There was an error fething the user profle");
    }
  }

  Future<bool> logOut() async {
    try {
      await facebookSignIn.logOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
