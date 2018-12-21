import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/screens/authentication/login.dart';
import 'package:discoucher/screens/authentication/sign-up.dart';
import 'package:discoucher/screens/authentication/sign_up_pay_prompt.dart';
import 'package:discoucher/screens/authentication/pay_prompt.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:discoucher/screens/settings/about.dart';
import 'package:discoucher/screens/settings/contacts-section.dart';
import 'package:discoucher/screens/settings/discoucher-process.dart';
import 'package:discoucher/screens/settings/setting-item.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/contollers/settings-controller.dart';

// settings for a logged out user or one that has not signed up

Widget loggedOutUserSettings(
    BuildContext context, SettingsController controller) {
  return Column(
    children: <Widget>[
      SizedBox(height: 20.0),
      RaisedButton(
        onPressed: () {
          Navigator.push(context, SignUpPageRoute());
          // Navigator.push(context, SignUpPayPromptRoute());
          // Navigator.push(context, PayPromptRoute());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
          child: Text(
            // Note, the spaces here are to make sure the buttons are of the same size.
            '       Sign Up        ',
            style: TextStyle(color: Colors.white, fontSize: 17.0),
          ),
        ),
        color: Theme.of(context).primaryColor,
        elevation: 1.0,
      ),
      SizedBox(height: 5.0),
      OutlineButton(
        onPressed: () {
          Navigator.push(context, LogInPageRoute(fromSplashScreen: false));
        },
        padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        borderSide: BorderSide(color: xDiscoucherGreen),
        child: boldGreenText("Log in to Discoucher"),
      ),
      SizedBox(height: 10.0),
      buildSettingItem(
          tapEvent: () {
            Navigator.push(
                context, DiscoucherProcessRoute(user: null, ctrl: controller));
          },
          icon: Icons.help,
          displayText: "Discoucher process"),
      buildSettingItem(
          tapEvent: () {
            Navigator.push(context, AboutRoute(ctrl: controller));
          },
          icon: Icons.info,
          displayText: "About Discoucher"),
      buildContactsSection(controller),
    ],
  );
}
