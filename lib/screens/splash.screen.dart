import 'dart:async';

import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/authentication/login.dart';
import 'package:discoucher/screens/home/entry.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:discoucher/screens/settings/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DiscoucherRoutes routes = new DiscoucherRoutes();

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Welcome to Discoucher")),
    );
  }

  Future<LoggedInUser> checkLoggedIn() async {
    final SharedPrefefencedController prefs = new SharedPrefefencedController();
    return await prefs.fetchLoggedInUser();
  }

  startTimer() async {
    final hasUser = await checkLoggedIn();
    if (hasUser != null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      }));
    } else {
      const timeout = const Duration(seconds: 1, milliseconds: 500);
      new Timer(timeout, () {
        try {
          var firstTimeUsingApp = true;

          if (firstTimeUsingApp) {
            //Navigator.of(context).pushReplacementNamed('/tutorials');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return TutorialPage();
            }));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return LoginPage(
                fromSplashScreen: true,
              );
            }));
          }
        } catch (error) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return LoginPage(
              fromSplashScreen: true,
            );
          }));
        }
      });
    }
  }
}
