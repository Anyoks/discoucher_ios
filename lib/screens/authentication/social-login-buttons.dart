import 'package:discoucher/contollers/facebook-login.dart';
import 'package:discoucher/contollers/google-signIn.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/facebook-user.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginButtons extends StatelessWidget {
  SocialLoginButtons(this._routes, this._prefs);

  final SharedPreferencesController _prefs;
  final DiscoucherRoutes _routes;
  final FacebookLoginController fb = new FacebookLoginController();
  final GoogleSignInController google = new GoogleSignInController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Continue With"),
          FlatButton(
            onPressed: () => attemptFacebookLogin(context),
            child: Row(
              children: <Widget>[
                Image.asset("images/social/facebook.png", width: 20.0),
                Padding(padding: EdgeInsets.only(left: 3.0)),
                Text("Facebook")
              ],
            ),
          ),
          FlatButton(
              onPressed: () => attemptGoogleLogin(context),
              child: Row(
                children: <Widget>[
                  Image.asset("images/social/google.png", width: 20.0),
                  Padding(padding: EdgeInsets.only(left: 3.0)),
                  Text("Google", style: TextStyle(fontSize: 14.0))
                ],
              )),
        ],
      ),
    );
  }

  attemptGoogleLogin(BuildContext context) async {
    try {
      LoginResults results = await google.signIn();
      switch (results.success) {
        case true:
          goHome(context);
          GoogleSignInAccount profile = results.profile;
          saveLoggedInUser(LoggedInUser(
            id: profile.id,
            email: profile.email,
            fullName: profile.displayName,
            photoUrl: profile.photoUrl,
            token: results.token,
          ));
          break;
        default:
          showErrorMessage(context, results.message);
      }
    } catch (errorMessage) {
      showErrorMessage(context, errorMessage);
    }
  }

  attemptFacebookLogin(BuildContext context) async {
    // waitForLogin(context);
    try {
      LoginResults results = await fb.login();
      switch (results.success) {
        case true:
          FacebookAccessToken token = results.token;
          FacebookProfile profile = results.profile;

          saveLoggedInUser(LoggedInUser(
              id: profile.id,
              email: profile.email,
              fullName: profile.name,
              photoUrl: profile.picture.data.url,
              bytes: profile.bytes,
              token: token.token));
          goHome(context);
          break;
        default:
          showErrorMessage(context, results.message);
      }
    } catch (errorMessage) {
      showErrorMessage(context, errorMessage);
    }
  }

  showErrorMessage(BuildContext context, dynamic error) {
    if (error.runtimeType == String) {
      Duration timeout = new Duration(seconds: 3);
      final snackBar = SnackBar(
        duration: timeout,
        content: Text(error),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  waitForLogin(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute<bool>(builder: (BuildContext context) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }

  goHome(BuildContext context) =>
      Navigator.pushReplacementNamed(context, _routes.homeRoute);

  saveLoggedInUser(LoggedInUser user) async =>
      await _prefs.updateLoggedInUser(user);
}
