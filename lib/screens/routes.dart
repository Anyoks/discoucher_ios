import 'package:discoucher/screens/authentication/login.dart';
import 'package:discoucher/screens/home/home.dart';
import 'package:discoucher/screens/playground/play.dart';
import 'package:discoucher/screens/settings/settings.dart';
import 'package:discoucher/screens/settings/tutorial.dart';
import 'package:discoucher/screens/splash.screen.dart';
import 'package:flutter/material.dart';

class DiscoucherRoutes {
  SplashScreen splashScreen;

  String homeRoute = '/home';
  String splashScreenRoute = '/splashScreen';
  String tutorialsRoute = '/tutorial';
  String loginRoute = '/login';

  Map<String, WidgetBuilder> routes;

  DiscoucherRoutes() {
    splashScreen = new SplashScreen();
    routes = _buildRoutes();
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return <String, WidgetBuilder>{
      homeRoute: (BuildContext context) => HomePage(),
      splashScreenRoute: (BuildContext context) => SplashScreen(),
      tutorialsRoute: (BuildContext context) => TutorialPage(),
      loginRoute: (BuildContext context) => LoginPage(
            fromSplashScreen: false,
          )
    };
  }

  goAndNeverComeback(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed('/$pageName');
  }

  go(BuildContext context, String pageName) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      switch (pageName) {
        case "LoginPage":
          {
            return LoginPage(
              fromSplashScreen: false,
            );
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
            return LoginPage(
              fromSplashScreen: false,
            );
          }
      }
    }));
  }
}
