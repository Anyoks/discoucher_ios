import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  AppBarTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
