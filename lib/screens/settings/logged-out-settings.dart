import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/authentication/login.dart';
import 'package:discoucher/screens/settings/about.dart';
import 'package:discoucher/screens/settings/contacts-section.dart';
import 'package:discoucher/screens/settings/discoucher-process.dart';
import 'package:discoucher/screens/settings/setting-item.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/contollers/settings-controller.dart';

Widget loggedOutUserSettings(
    BuildContext context, SettingsController controller) {
  return Column(
    children: <Widget>[
      SizedBox(height: 20.0),
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
