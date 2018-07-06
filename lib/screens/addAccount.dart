import 'package:flutter/material.dart';

class AddAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("New Account")
      ),
      body: new Center(child: new Text("Add new account")),
    );
  }
}
