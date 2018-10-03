import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/profile/profile.dart';
import 'package:discoucher/screens/settings/about.dart';
import 'package:discoucher/screens/settings/contacts-section.dart';
import 'package:discoucher/screens/settings/discoucher-process.dart';
import 'package:discoucher/screens/settings/favorites.dart';
import 'package:discoucher/screens/settings/redeemed-offers.dart';
import 'package:discoucher/screens/settings/setting-item.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/screens/settings/user-avatar.dart';

openProfilePage(BuildContext context, LoggedInUser user) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return ProfilePage(currentUser: user);
  }));
}

Widget buildLoggedInUser({
  BuildContext context,
  SettingsController controller,
  LoggedInUser user,
  Function logOut,
}) {
  if (user != null) {
    return Column(
      children: <Widget>[
        buildUserAvatar(user),
        loggedInUserSettings(context, controller, user, logOut),
      ],
    );
  } else {
    return Container();
  }
}

Widget loggedInUserSettings(
  BuildContext context,
  SettingsController controller,
  LoggedInUser user,
  Function logOut,
) {
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
            controller.logOut().then((onValue) => logOut());
          },
          icon: Icons.exit_to_app,
          displayText: "Log out"),
      buildContactsSection(controller),
    ],
  );
}
