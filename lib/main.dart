import 'package:discoucher/screens/settings/tutorial.dart';
import 'package:flutter/material.dart';
import 'screens/home/entry.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Discoucher",
      theme: new ThemeData(
          // brightness: Brightness.light,
          primaryColor: Colors.green[900],
          accentColor: Colors.red[700],
          scaffoldBackgroundColor: Colors.white),
      home: new HomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomePage(),
        '/tutorial': (BuildContext context) => new TutorialPage(),
      },
    ),
  );
}
