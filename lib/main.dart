import 'package:flutter/material.dart';
import 'screens/home/entry.dart';

void main() {
  runApp(new MaterialApp(
      title: "DisCucher",
      theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green[900],
          accentColor: Colors.red[700],
          scaffoldBackgroundColor: Colors.white
      ),
      home: new HomePage()));
}
