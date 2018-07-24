import 'package:discoucher/screens/settings/tutorial.dart';
import 'package:flutter/material.dart';
import 'screens/home/entry.dart';

void main() {
  runApp(
   MaterialApp(
      title: "Discoucher",
      theme:ThemeData(
          // brightness: Brightness.light,
          primaryColor: Colors.green[900],
          accentColor: Colors.red[700],
          scaffoldBackgroundColor: Colors.white),
      home: TutorialPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) =>HomePage(),
        '/tutorial': (BuildContext context) =>TutorialPage(),
      },
    ),
  );
}
