import 'dart:async';

import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/authentication/social-login-buttons.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage();

  final SharedPrefefencedController prefs = SharedPrefefencedController();
  final DiscoucherRoutes routes = DiscoucherRoutes();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 200.0,
            child: Container(
              // color: Colors.grey,
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
          SocialLoginButtons(routes, scaffoldKey, prefs)
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
      return Container();
    }
  }
}
