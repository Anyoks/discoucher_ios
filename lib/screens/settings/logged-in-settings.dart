import 'package:discoucher/models/shared.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/constants/enums.dart';
import 'package:discoucher/constants/colors.dart';

Widget buildLoggedInUser(
    {BuildContext context, SettingsController controller, LoggedInUser user}) {
  if (user != null) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            height: 150.0,
            width: 150.0,
            alignment: Alignment(0.0, 1.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: user.photoUrl != null
                    ? NetworkImage(user.photoUrl)
                    : AssetImage("images/item-placeholder.jpg"),
              ),
            ),
            child: null,
          ),
        ),
        Column(
          children: <Widget>[
                      SizedBox(height: 10.0),

            Text(user.fullName),
            Text(user.email),
          ],
        ),
        loggedInUserSettings(controller),
      ],
    );
  } else {
    // TODO: Add placeholder image
    return Container();
  }
}

Widget loggedInUserSettings(SettingsController controller) {
  return Column(
    children: <Widget>[
      buildSettingItem(
          tapEvent: () {}, icon: Icons.account_circle, displayText: "Profile"),
      buildSettingItem(
          tapEvent: () {}, icon: Icons.receipt, displayText: "Redeemed Deals"),
      buildSettingItem(
          tapEvent: () {}, icon: Icons.favorite, displayText: "Favorites"),
      buildSettingItem(
          tapEvent: () {}, icon: Icons.help, displayText: "Discoucher process"),
      buildSettingItem(
          tapEvent: () {}, icon: Icons.info, displayText: "About Discoucher"),
      buildSettingItem(
          tapEvent: () {}, icon: Icons.exit_to_app, displayText: "Log out"),
      Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text("CONTACT-US", style: TextStyle(fontSize: 18.0))),
      buildSettingItem(
          tapEvent: () {
            controller.call();
          },
          icon: Icons.phone,
          displayText: discoucherPhone),
      buildSettingItem(
          tapEvent: () {
            controller.email();
          },
          icon: Icons.email,
          displayText: discoucherEmail),
      buildSettingItem(
          tapEvent: () {
            controller.lauchSocial(SocialSite.Website);
          },
          icon: Icons.link,
          displayText: discoucherWebsite)
    ],
  );
}

Widget buildSettingItem(
    {@required Function tapEvent,
    @required IconData icon,
    @required String displayText}) {
  return InkWell(
    onTap: tapEvent,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 15.0),
              Icon(icon, color: xGreenIconColor),
              SizedBox(width: 15.0),
              Expanded(
                child: Text(displayText, style: TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 55.0),
            height: 1.0,
            color: Colors.grey.withOpacity(0.5))
      ],
    ),
  );
}
