import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/profile/profile.dart';
import 'package:discoucher/screens/settings/about.dart';
import 'package:discoucher/screens/settings/discoucher-process.dart';
import 'package:discoucher/screens/settings/favorites.dart';
import 'package:discoucher/screens/settings/redeemed-offers.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/constants/enums.dart';
import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/screens/settings/user-avatar.dart';

openProfilePage(BuildContext context, LoggedInUser user) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return ProfilePage(currentUser: user);
  }));
}

Widget buildLoggedInUser(
    {BuildContext context, SettingsController controller, LoggedInUser user}) {
  if (user != null) {
    return Column(
      children: <Widget>[
        buildUserAvatar(user),
        loggedInUserSettings(context, controller, user),
      ],
    );
  } else {
    // TODO: Add placeholder image
    return Container();
  }
}

Widget loggedInUserSettings(
    BuildContext context, SettingsController controller, LoggedInUser user) {
  return Column(
    children: <Widget>[
      buildSettingItem(
          tapEvent: () {
            Navigator.push(context, ProfilePageRoute(user));
          },
          icon: Icons.account_circle,
          displayText: "Profile"),
      buildSettingItem(
          tapEvent: () {
            Navigator.push(context, RedeemedOffersRoute());
          },
          icon: Icons.receipt,
          displayText: "Redeemed Offers"),
      buildSettingItem(
          tapEvent: () {
            Navigator.push(context, FavoritesRoute());
          },
          icon: Icons.favorite,
          displayText: "Favorites"),
      buildSettingItem(
          tapEvent: () {
            Navigator.push(
                context, DiscoucherProcessRoute(user: user, ctrl: controller));
          },
          icon: Icons.help,
          displayText: "Discoucher process"),
      buildSettingItem(
          tapEvent: () {
            Navigator.push(context, AboutRoute(ctrl: controller));
          },
          icon: Icons.info,
          displayText: "About Discoucher"),
      buildSettingItem(
          tapEvent: () {
            controller.logOut();
          },
          icon: Icons.exit_to_app,
          displayText: "Log out"),
      Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text("CONTACT-US", style: TextStyle(fontSize: 18.0))),
      buildSettingItem(
          tapEvent: () {
            controller.call(discoucherPhone1);
          },
          icon: Icons.phone,
          displayText: discoucherPhone1),
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
              Icon(icon, color: xDiscoucherIconGreen),
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
