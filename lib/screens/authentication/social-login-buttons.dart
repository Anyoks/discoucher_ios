import 'package:discoucher/contollers/auth-controller.dart';
import 'package:discoucher/contollers/facebook-login.dart';
import 'package:discoucher/contollers/google-signIn.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/facebook-user.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';
import 'package:discoucher/screens/authentication/sign_up_pay_prompt.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginButtons extends StatelessWidget {
  SocialLoginButtons({this.fromTutorialPage});

  final bool fromTutorialPage;
  final AuthController _controller = new AuthController();
  final DiscoucherRoutes _routes = new DiscoucherRoutes();
  final FacebookLoginController fb = new FacebookLoginController();
  final GoogleSignInController google = new GoogleSignInController();
  static SharedPreferencesController _prefs = new SharedPreferencesController();
  final SettingsController controller = new SettingsController(prefs: _prefs);

  LoggedInUser loggedInUser;
  int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Continue With..."),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              OutlineButton(
                onPressed: () => loginToFacebook(context),
                 borderSide: BorderSide(color: Colors.grey),
                child: Row(
                  children: <Widget>[
                    Image.asset("images/social/facebook.png", width: 20.0),
                    Padding(padding: EdgeInsets.only(left: 3.0)),
                    Text("Facebook")
                  ],
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              OutlineButton(
                  onPressed: () => attemptGoogleLogin(context),
                  borderSide: BorderSide(color: Colors.grey),
                  child: Row(
                    children: <Widget>[
                      Image.asset("images/social/google.png", width: 20.0),
                      Padding(padding: EdgeInsets.only(left: 3.0)),
                      Text("Google", style: TextStyle(fontSize: 14.0))
                    ],
                  )),
            ],
          ),
          // Text("Continue With"),
        ],
      ),
    );
  }

  attemptGoogleLogin(BuildContext context) async {
    try {
      LoginResults results = await google.signIn();
      switch (results.success) {
        case true:
          User user = results.profile;

          print("BACK FROM GOOGLE LOGIN");
          print(user);
          if (user != null) {
            LoggedInUser loggedinUSer2 = new LoggedInUser(
              id: user.id,
              email: user.email,
              firstName: user.firstName,
              lastName: user.lastName,
              fullName: "${user.firstName} ${user.firstName}",
              phoneNumber: user.phoneNumber,
              vouchers: user.vouchers,
            );

            await _controller.saveLoggedInUser(loggedinUSer2);
          }

          // goHome(context);
          goToPaymentPrompt(context);
          break;
        default:
          showErrorMessage(context, results.message);
      }
    } catch (errorMessage) {
      showErrorMessage(context, "${errorMessage.toString()}");
    }
  }

  loginToFacebook(BuildContext context) async {
    try {
      LoginResults results = await fb.loginToFacebook();
      switch (results.success) {
        case true:
          print("BACK FROM FACEBOOK LOGIN");
          // FacebookAccessToken token = results.token;
          // FacebookProfile profile = results.profile;
          User user = results.profile;

          if (user != null) {
            // only does this for logged in users because the login method does not do it!
            LoggedInUser loggedinUSer2 = new LoggedInUser(
              id: user.id,
              email: user.email,
              firstName: user.firstName,
              lastName: user.lastName,
              fullName: "${user.firstName} ${user.firstName}",
              phoneNumber: user.phoneNumber,
              vouchers: user.vouchers,
            );

            await _controller.saveLoggedInUser(loggedinUSer2);
          }

          // goHome(context);
          goToPaymentPrompt(context);
          break;
        default:
          showErrorMessage(context, results.message);
      }
    } catch (errorMessage) {
      showErrorMessage(context, errorMessage.toString());
    }
  }

   goToPaymentPrompt(BuildContext context){
    // var g = getuser(context);
    getuser(context);
    // print("USer in Social login SCREEN $g");
    // Navigator.push(context, MaterialPageRoute(
    //         builder: (context) => SignUpPayPrompt(loggedInUser: loggedInUser)));
  }


  getuser(BuildContext context) async {
    await controller.checkLoggedIn().then((data) {
      
        if (data != null) {
            loggedInUser = data;
            print( "Social login check  user"+ loggedInUser.email);
            // return loggedInUser;
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => SignUpPayPrompt(loggedInUser: loggedInUser)));
        } else {
          // check again because the first check always retursn null
          // this is a work around.
          if (counter < 2) {
            counter++;
            getuser(context);
          } else {
            counter = 0;
            // loggedInUser = null;
          }
        }
     
    });
  }



  showErrorMessage(BuildContext context, String error) {
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

  goHome(BuildContext context) {
    // print("fromTutorialPage");
    // print(fromTutorialPage);

    // fromTutorialPage != null && fromTutorialPage
    //     ? Navigator.popAndPushNamed(context, _routes.homeRoute)
    //     : Navigator.pop(context);

    Navigator.popAndPushNamed(context, _routes.homeRoute);
    // Navigator.pushReplacementNamed(context, _routes.homeRoute);
  }
}
