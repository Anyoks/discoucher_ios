import 'package:discoucher/screens/authentication/login.dart';
import 'package:discoucher/screens/settings/tutorial.dart';
import 'package:discoucher/screens/splash.screen.dart';
import 'package:flutter/material.dart';
import 'screens/home/entry.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Discoucher",
      theme: _discoucherTheme,
      home: SplashScreen(),
     // initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/splashScreen': (BuildContext context) => SplashScreen(),
        '/tutorial': (BuildContext context) => TutorialPage(),
        '/login': (BuildContext context) => LoginPage(fromSplashScreen: false,),
      },
    ),
  );
}


final discoucherGreen900 = Colors.green[900];
final discoucherRed700 = Colors.red[700];
final discoucherPink100 = Color(0xFFC2185B);
final discoucherPurple = Color(0xFFe040fb);
final discoucherErrorRed =Color(0xFFC5032B);
final discoucherSurfaceWhite = Color(0xFFFFFBFA);
final discoucherBackgroundWhite = Colors.white;

final ThemeData _discoucherTheme = _buildDiscoucherTheme();

ThemeData _buildDiscoucherTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: discoucherRed700,
    primaryColor: discoucherGreen900,
    buttonColor: discoucherGreen900,
    scaffoldBackgroundColor: discoucherBackgroundWhite,
    cardColor: discoucherBackgroundWhite,
    textSelectionColor: discoucherPink100,
    errorColor: discoucherErrorRed, 
    splashColor: discoucherPurple.withOpacity(0.5),

    // TODO: Add the text themes (103)
    // TODO: Add the icon themes (103)
    // TODO: Decorate the inputs (103)
  );
}
