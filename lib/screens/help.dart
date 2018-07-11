import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Help")),
      body: new Center(
        child: new Center(
          child: GestureDetector(
            child: Hero(
              tag: 'image-hero',
              child: Image.asset(
                "images/establishments/mayura.jpg",
                fit: BoxFit.fitWidth,
                width: 300.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
