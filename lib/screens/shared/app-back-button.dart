import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios, color: Colors.black),
    );
  }
}
