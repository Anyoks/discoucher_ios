import 'dart:async';

import 'package:discoucher/constants/pref-paths.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    _startTimer();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Welcome to Discoucher")));
  }

  _startTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasEverBeenLaunched = prefs.getBool(PrefPaths.isInitialLaunch);

    if (hasEverBeenLaunched != null && hasEverBeenLaunched) {
      Navigator.pushReplacementNamed(context, routes.homeRoute);
    } else {
      Duration timeout = Duration(seconds: 1, milliseconds: 500);
      Timer(timeout, () {
        // Navigator.pushReplacementNamed(context, routes.tutorialsRoute);
        Navigator.pushReplacementNamed(context, routes.homeRoute);
      });
    }
  }
}
