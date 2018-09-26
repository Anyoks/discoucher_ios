import 'package:discoucher/constants/enums.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/screens/settings/setting-item.dart';
import 'package:flutter/material.dart';

buildContactsSection(SettingsController controller) {
  return Column(
    children: <Widget>[
      Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text("CONTACT-US", style: TextStyle(fontSize: 18.0))),
      buildSettingItem(
        tapEvent: () {
          controller.call(discoucherPhone1);
        },
        icon: Icons.phone,
        displayText: discoucherPhone1,
      ),
      buildSettingItem(
        tapEvent: () {
          controller.email(discoucherEmail);
        },
        icon: Icons.email,
        displayText: discoucherEmail,
      ),
      buildSettingItem(
        tapEvent: () {
          controller.lauchSocial(SocialSite.Website);
        },
        icon: Icons.link,
        displayText: discoucherWebsite,
      )
    ],
  );
}
