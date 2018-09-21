import 'package:flutter/material.dart';
import 'package:discoucher/constants/colors.dart';

Widget buildAnonymousSettings() {
  return GestureDetector(
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Icon(
              Icons.verified_user,
              color: xDiscoucherIconGreen,
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Text(
                "Profile",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
