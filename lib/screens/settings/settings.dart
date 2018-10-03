import 'dart:async';

import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/settings/logged-in-settings.dart';
import 'package:discoucher/screens/settings/logged-out-settings.dart';
import 'package:discoucher/screens/settings/user-avatar.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/screens/settings/bottom-sections.dart';

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

  buildSettingsSections(BuildContext context, LoggedInUser user) {
    if (user != null) {
      return Column(
        children: <Widget>[
          buildUserAvatar(user),
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
