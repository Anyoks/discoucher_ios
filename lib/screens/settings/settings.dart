import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Settings")),
      body: Center(
        child: InkWell(
            onTap: () {},
            child: Center(
              child: Text("Settings"),
            )),
      ),
    );
  }
}