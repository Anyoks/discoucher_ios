import 'package:discoucher/screens/authentication/login.dart';
import 'package:discoucher/screens/home/entry.dart';
import 'package:discoucher/screens/playground/play.dart';
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
        case "LoginPage":
          {
            return LoginPage(fromSplashScreen: false,);
          }
        case "HomePage":
          {
            return HomePage();
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
            return LoginPage(fromSplashScreen: false,);
          }
      }
    }));
  }
}
