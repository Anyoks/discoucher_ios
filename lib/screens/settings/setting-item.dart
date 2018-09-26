

import 'package:discoucher/constants/colors.dart';
import 'package:flutter/material.dart';

Widget buildSettingItem({
  @required Function tapEvent,
  @required IconData icon,
  @required String displayText,
}) {
  return InkWell(
    onTap: tapEvent,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 15.0),
              Icon(icon, color: xDiscoucherGreen),
              SizedBox(width: 15.0),
              Expanded(
                child: Text(displayText, style: TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 55.0),
            height: 1.0,
            color: Colors.grey.withOpacity(0.5))
      ],
    ),
  );
}
