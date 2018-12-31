import 'dart:async';
import 'dart:convert';
import 'package:discoucher/contollers/auth-controller.dart';
import 'package:discoucher/models/user.dart';
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

  final AuthController _controller = new AuthController();
  String email;

  User user = new User();

  Future<bool> signUpUser(account) async {
    user.email = account.email;
    user.firstName = account.firstName;
    user.lastName = account.lastName;
    user.password = user.firstName;
    user.passwordConfirmation = user.firstName;
    user.provider = "facebook";

    print(" SIgn up FIrst name " + account.firstName);

    SignUpResults signUpResults = await _controller.signUp(user);
    if (signUpResults != null && signUpResults.status) {
      // success
      print(" Inside  Sing up SUCCESS");
      return true;
    } else {
      // error
      print(" Inside  Sing up ERROR");
      return false;
    }
  }

  Future<User> loginUser(account) async {
    String password = account.firstName;
    var user = await _controller.login(email, password);

    if (user != null) {
      LoggedInUser _userToSave = new LoggedInUser(
        id: user.id,
        fullName: "${user.firstName} ${user.lastName}",
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        vouchers: user.vouchers,
      );
      print(" Inside  LOGIN SUCCESS" + user.email);
      return user;
    } else {
      //error
      print(" Inside  LOGIN ERROR");
      return null;
    }
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

      print(" FACE BOOK 1" + userProfile.firstName);
      print(" FACE BOOK 2" + userProfile.lastName);
      print(" FACE BOOK 3" + userProfile.email);

      email = userProfile.email;

      String result = await _controller.checkUser(email);

      if (result == 'true') {
        // login user
        var login = await loginUser(userProfile);

        if (login != null) {
          // success
          print(" Inside  GOOGLE SUCCESS" + login.email);
          return new LoginResults(
            success: true,
            profile: login,
            message: "Login successful",
          );
        } else {
          // failure
          return new LoginResults(
            success: false,
            profile: null,
            message: "Error Logging in",
          );
        }
      } else if (result == 'false') {
        // sign up user
        bool status = await signUpUser(userProfile);

        if (status) {
          return new LoginResults(
            success: true,
            profile: null,
            message: "Login successful",
          );
        }
      } else {
        // error connecting.
        return new LoginResults(
          success: true,
          profile: null,
          message: " Error connecting to Server",
        );
      }

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
