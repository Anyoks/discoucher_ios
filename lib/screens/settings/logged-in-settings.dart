import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/home/home.dart';
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
import 'package:discoucher/screens/authentication/pay_prompt.dart';

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
    print("qqqqqqqq ${user.vouchers}");
    return Column(
      children: <Widget>[
        buildUserAvatar(user),
        buildGetOffers(context, controller, user),
        loggedInUserSettings(context, controller, user, logOut),
      ],
    );
  } else {
    return Container();
  }
}

void _submit(LoggedInUser user, BuildContext context) {
  if (user.vouchers == 'valid' || user.vouchers == 'free') {
    // user has vouchers go to home page
    Navigator.push(context, HomePageRoute());
  } else {
    // depleted or none
    // user has no vouchers they should make a purchase
    Navigator.push(context, PayPromptRoute(user));
  }
}

Widget buildGetOffers(
  BuildContext context,
  SettingsController controller,
  LoggedInUser user,
) {
  return Column(
    children: <Widget>[
      user.vouchers == 'none' || user.vouchers == 'depleted'
          ? RaisedButton(
              onPressed: () {
                //check if the user has valid offers  if not, they need to pay if yes, go to home page
                print("qqqqqqqq ${user.vouchers}");
                Navigator.push(context, PayPromptRoute(user));
                // _submit(user,context);

                // Navigator.push(context, SignUpPayPromptRoute());
                // Navigator.push(context, PayPromptRoute());
              },
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
            )
          : Container(),
    ],
  );
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
