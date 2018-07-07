import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new TextField(
          autofocus: true,
          autocorrect: true,
          style: new TextStyle(color: Colors.white),
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: 'Search discounts',
              hintStyle: new TextStyle(color: Colors.lightGreen)),
        ),
      ),
      body: new Center(child: new Text("..search results")),
    );
  }
}
