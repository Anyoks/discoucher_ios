import 'dart:async';

import 'package:discoucher/screens/routes.dart';
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
    SystemChrome.setEnabledSystemUIOverlays(
        []); // Give the navigation animations, etc, some time to finish
    Future.delayed(Duration(seconds: 1)).then((_) {
      var firstTimeUsingApp = true;
      if (firstTimeUsingApp) {
        routes.go(context, "TutorialPage");
      }
      routes.go(context, "LoginPage");
    });
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Welcome to Discoucher")),
    );
  }
}
