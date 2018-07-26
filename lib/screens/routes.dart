import 'package:discoucher/screens/authentication/login.dart';
import 'package:discoucher/screens/home/entry.dart';
import 'package:discoucher/screens/nearby/nearby.dart';
import 'package:discoucher/screens/playground/fading.dart';
import 'package:discoucher/screens/playground/play.dart';
import 'package:discoucher/screens/playground/presto.dart';
import 'package:discoucher/screens/settings/settings.dart';
import 'package:discoucher/screens/settings/tutorial.dart';
import 'package:flutter/material.dart';

class DiscoucherRoutes {
  goAndNeverComeback(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed('/${pageName}');
  }

  go(BuildContext context, String pageName) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      switch (pageName) {
        case "PlayPage":
          {
            return PlayPage(title: "Play Page");
          }
        case "PrestoPage":
          {
            return PrestoPage();
          }
        case "FadingPage":
          {
            return FadingPage();
          }
        case "LoginPage":
          {
            return LoginPage();
          }
        case "HomePage":
          {
            return HomePage();
          }
        case "NearbyPage":
          {
            return NearbyPage();
          }
        case "SettingsPage":
          {
            return SettingsPage();
          }
        case "TutorialPage":
          {
            return TutorialPage();
          }
        default:
          {
            return LoginPage();
          }
      }
    }));
  }
}
