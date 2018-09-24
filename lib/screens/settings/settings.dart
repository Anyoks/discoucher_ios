import 'package:discoucher/screens/settings/anonymous-user-settings.dart';
import 'package:discoucher/screens/settings/logged-in-settings.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/screens/settings/bottom-sections.dart';

class SettingsPage extends StatelessWidget {
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static SharedPrefefencedController _prefs = new SharedPrefefencedController();
  final SettingsController controller =
      new SettingsController(prefs: _prefs, scaffoldKey: _scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            future: controller.checkLoggedIn(),
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
                    return buildAnonymousSettings();
                  else
                    return buildLoggedInUser(
                        context: context,
                        controller: controller,
                        user: snapshot.data);
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
}
