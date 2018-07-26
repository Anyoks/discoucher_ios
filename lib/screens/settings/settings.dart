import 'dart:async';

import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/authentication/social-login-buttons.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final SharedPrefefencedController prefs = new SharedPrefefencedController();
  final DiscoucherRoutes routes = DiscoucherRoutes();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 200.0,
            child: Container(
              color: Colors.grey,
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
                        return new Text('An error happened: ${snapshot}');
                      else
                        return profileSectionBuilder(context, snapshot.data) ??
                            Container();
                  }
                },
              ),
            ),
          ),
          SocialLoginButtons(routes, scaffoldKey, prefs)
        ],
      ),
    );
  }

  Future<LoggedInUser> checkLoggedIn() async {
    final SharedPrefefencedController prefs = new SharedPrefefencedController();
    return await prefs.fetchLoggedInUser();
  }

  Widget profileSectionBuilder(BuildContext context, LoggedInUser user) {
    if (user != null) {
      return Text(user.toJson().toString());
    }
    return null;
  }
}
