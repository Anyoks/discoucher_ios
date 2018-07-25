import 'package:discoucher/contollers/facebook-login.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  final DiscoucherRoutes routes;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final FacebookLoginController fb = new FacebookLoginController();

  SocialLoginButtons(this.routes, this.scaffoldKey);

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
    var results = await waitForLogin(context);
    print(results);
  }

  attemptFacebookLogin(BuildContext context) async {
    // waitForLogin(context);
    try {
      LoginResults results = await fb.login();

      switch (results.success) {
        case true:
          //routes.go(context, "HomePage");
          Navigator.pushNamed(context, '/');
          // showErrorMessage("Welcome");
          break;
        default:
          showErrorMessage(results.message);
      }
    } catch (errorMessage) {
      showErrorMessage(errorMessage);
    }
  }

  showErrorMessage(String error) {
    final snackbar = SnackBar(
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
            child: CircularProgressIndicator(
              value: null,
            ),
          ),
        );
      }),
    );
  }
}
