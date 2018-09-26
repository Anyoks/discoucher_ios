import 'package:discoucher/constants/colors.dart';
import 'package:flutter/material.dart';

buildEstablishmentItem(IconData icon, String title) {
  if (title == null) {
    title = "";
  }

  return title.length < 1
      ? Container()
      : Column(
          children: <Widget>[
            SizedBox(width: 10.0),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Icon(icon, color: Colors.green[900]),
                SizedBox(width: 15.0),
                Flexible(
                  child: Text(
                    title.trim(),
                    style: TextStyle(color: xSubtitileColor),
                  ),
                  fit: FlexFit.tight,
                ),
                SizedBox(width: 15.0),
              ],
            ),
            SizedBox(width: 10.0),
            Divider(color: Colors.green),
          ],
        );
}
