import 'dart:async';

import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';
import 'package:discoucher/screens/settings/logged-in-settings.dart';
import 'package:discoucher/screens/settings/logged-out-settings.dart';
import 'package:discoucher/screens/settings/user-avatar.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/screens/settings/bottom-sections.dart';
import 'package:discoucher/screens/authentication/pay_prompt.dart';

// settings page for a logged in User
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static SharedPreferencesController _prefs = new SharedPreferencesController();
  final SettingsController controller = new SettingsController(prefs: _prefs);
  Future<LoggedInUser> loggedInUser;

  @override
  initState() {
    super.initState();

    loggedInUser = controller.checkLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    checkUser();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarsettings,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future: loggedInUser,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return loggedOutUserSettings(context, controller);
                case ConnectionState.waiting:
                  return Container(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                default:
                  // print("snapshot.data");
                  // print(snapshot.data.toString());
                  return buildSettingsSections(context, snapshot.data);
                // if (snapshot.hasError || !snapshot.hasData) {
                //   return buildSettingsSections(context, snapshot.data);
                // } else {
                //   return loggedOutUserSettings(context, controller);
                // }
              }
            },
          ),
          SizedBox(height: 15.0),
          buildBottomSection(controller),
          SizedBox(height: 25.0),
          Center(child: Text(appVersion, style: TextStyle(color: Colors.grey))),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }

  //  goToPaymentPrompt(LoggedInUser user){
  //   // String hR = _routes.homeRoute.toString();
  //   // String pR = _routes.signUpPaymentRoute.toString();
  
  //   // print("This is the home route  $hR");
  //   // print("THis is the payment route $pR");
  //   // Navigator.popAndPushNamed(context, _routes.signUpPaymentRoute);
  //   print("USer in SIgn Up SCREEN $user");
  //   Navigator.push(context, MaterialPageRoute(
  //           builder: (context) => PayPrompt(user: user)));
  // }

  buildGetOffers(
    LoggedInUser user,
  ) {
    return Column(
      children: <Widget>[
        // if the user has paid no need to show the get offers button!
         user.vouchers == 'none' || user.vouchers == 'depleted' || user.vouchers == 'free' ? RaisedButton(
          onPressed: ()  {
            goToPaymentPrompt(user);
          print("qqqqqqqq ${user.vouchers}");
          }, //() {
            //rint('DOING IT');
            
            //Navigator.push(context, PayPromptRoute(user));
            // Navigator.push(context, SignUpPayPromptRoute());
            // Navigator.push(context, PayPromptRoute());
         // },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
            child: Text(
              // Note, the spaces here are to make sure the buttons are of the same size.
              '    Get Offers     ',
              style: TextStyle(color: Colors.white, fontSize: 17.0),
            ),
          ),
          color: Theme.of(context).primaryColor,
          elevation: 1.0,
        ): Container(),
      ],

    );
  }

  goToPaymentPrompt(LoggedInUser user){
    print("USer in SIgn Up SCREEN ${user.lastName}");
    Navigator.push(context, MaterialPageRoute(
            builder: (context) => PayPrompt(user: user)));
  }

  buildSettingsSections(BuildContext context, LoggedInUser user) {
    if (user != null) {
      return Column(
        children: <Widget>[
          buildUserAvatar(user),
          buildGetOffers(user),
          loggedInUserSettings(
            context,
            controller,
            user,
            () => logOut(),
          ),
        ],
      );
    } else {
      return loggedOutUserSettings(context, controller);
    }
  }

  logOut() {
    if (this.mounted) {
      setState(() => loggedInUser = null);
    }
  }

  checkUser() {
    if (this.mounted) {
      setState(() {
        loggedInUser = controller.checkLoggedIn();
      });
    }
  }
}
