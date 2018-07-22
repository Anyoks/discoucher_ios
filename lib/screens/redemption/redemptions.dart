import 'package:flutter/material.dart';

class RedemptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Redemptions")
      ),
      body: new Center(child: new Text("You are yet to redeem a coucher")),
    );
  }
}
