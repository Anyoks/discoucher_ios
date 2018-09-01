import 'dart:async';

import 'package:flutter/material.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/authentication/social-login-buttons.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/settings-controller.dart';

class SettingsPage extends StatelessWidget {
  final SharedPrefefencedController prefs = SharedPrefefencedController();
  final DiscoucherRoutes routes = DiscoucherRoutes();
  final SettingsController settingsController = SettingsController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final xIconColor = Color(0xFF27AE60);

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 200.0,
            child: Container(
              child: FutureBuilder(
                future: checkLoggedIn(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("Nothing to show :(");
                    case ConnectionState.waiting:
                      return Container(
                          // color: Colors.amber,.
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    default:
                      if (snapshot.hasError)
                        return Text('An error happened: ${snapshot}');
                      else
                        return profileSectionBuilder(context, snapshot.data);
                  }
                },
              ),
            ),
          ),
          Column(
            children: <Widget>[
              buildSettingItem(
                  tapEvent: null,
                  icon: Icons.supervised_user_circle,
                  displayText: "Profile"),
              buildSettingItem(
                  tapEvent: () {},
                  icon: Icons.receipt,
                  displayText: "Redeemed Deals"),
              buildSettingItem(
                  tapEvent: null,
                  icon: Icons.favorite,
                  displayText: "Favorites"),
              buildSettingItem(
                  tapEvent: null,
                  icon: Icons.supervised_user_circle,
                  displayText: "Discoucher process"),
              buildSettingItem(
                  tapEvent: null,
                  icon: Icons.info,
                  displayText: "About Discoucher"),
              buildSettingItem(
                  tapEvent: null,
                  icon: Icons.supervised_user_circle,
                  displayText: "Log out"),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text("CONTACT-US", style: TextStyle(fontSize: 18.0))),
              buildSettingItem(
                  tapEvent: () {
                    settingsController.call("0700100200");
                  },
                  icon: Icons.phone,
                  displayText: "0700100200"),
              buildSettingItem(
                  tapEvent: () {
                    settingsController.email("hello@discoucher.com");
                  },
                  icon: Icons.email,
                  displayText: "hello@discoucher.com"),
              Row(
                children: <Widget>[
                  buildSocialIcon("Facebook"),
                  buildSocialIcon("Instagram"),
                  buildSocialIcon("Website"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future<LoggedInUser> checkLoggedIn() async {
    final SharedPrefefencedController prefs = SharedPrefefencedController();
    return await prefs.fetchLoggedInUser();
  }

  Widget profileSectionBuilder(BuildContext context, LoggedInUser user) {
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
              Text(user.fullName),
              Text(user.email),
            ],
          )
        ],
      );
    } else {
      // TODO: Add placeholder image
      return Container();
    }
  }

  Widget anonymousSettings() {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Icon(
                Icons.verified_user,
                color: xIconColor,
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  buildSocialIcon(String platform) {
    return Column(
      children: <Widget>[
        Image.asset("imageses/social/fb.png"),
        Text(platform, style: TextStyle(fontSize: 13.0))
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
                Icon(icon, color: xIconColor),
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
}
