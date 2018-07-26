import 'package:discoucher/contollers/facebook-login.dart';
import 'package:discoucher/contollers/google-signIn.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/home/entry.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  SocialLoginButtons(this.routes, this.scaffoldKey, this.prefs);

  final SharedPrefefencedController prefs;
  final DiscoucherRoutes routes;
  final GlobalKey<ScaffoldState> scaffoldKey;
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
                Image.asset("images/social/fb.png", width: 20.0),
                Padding(padding: EdgeInsets.only(left: 3.0)),
                Text("Facebook")
              ],
            ),
          ),
          FlatButton(
              onPressed: () => attemptGoogleLogin(context),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "images/social/google.png",
                    width: 20.0,
                  ),
                  Padding(padding: EdgeInsets.only(left: 3.0)),
                  Text(
                    "Google",
                    style: TextStyle(fontSize: 14.0),
                  )
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
          break;
        default:
          showErrorMessage(results.message);
      }
    } catch (errorMessage) {
      showErrorMessage(errorMessage);
    }
  }

  attemptFacebookLogin(BuildContext context) async {
    // waitForLogin(context);
    try {
      LoginResults results = await fb.login();
      switch (results.success) {
        case true:
          goHome(context);
          break;
        default:
          showErrorMessage(results.message);
      }
    } catch (errorMessage) {
      showErrorMessage(errorMessage);
    }
  }

  showErrorMessage(String error) {
    Duration timeout = new Duration(seconds: 3);
    final snackbar = SnackBar(
      duration: timeout,
      content: Text(error),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
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

  goHome(BuildContext context) {
    // Navigator.of(context).pushReplacementNamed('/');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return HomePage();
    }));
  }

  saveLoggedInUser(LoggedInUser user) async{
    var userSaved = await prefs.updateLoggedInUser(user);
    print(userSaved);
  }
}
