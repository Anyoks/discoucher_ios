import 'dart:math';

import 'package:discoucher/models/shared.dart';
import 'package:flutter/material.dart';

final List<Color> circleColors = [
  Colors.greenAccent,
  Colors.blueAccent,
  Colors.teal[400],
  Colors.indigoAccent,
  Colors.indigo[400]
];

int colousCount = circleColors.length;
Random random = new Random();

String _createInitials(String fullName) {
  if (fullName.length > 0) {
    final String firstInitial = fullName[0];

    final indexPrecedingSecondInitial = fullName.indexOf(" ");
    if (indexPrecedingSecondInitial > 0) {
      final String secondInitial = fullName[indexPrecedingSecondInitial + 1];
      if (secondInitial.length > 0) {
        return (firstInitial + secondInitial).toUpperCase();
      } else {
        return firstInitial;
      }
    } else {
      return firstInitial;
    }
  } else {
    return fullName;
  }
}

Widget _buldProfPic(LoggedInUser user) {
  return user.photoUrl == null
      ? Container()
      : CircleAvatar(backgroundImage: NetworkImage(user.photoUrl));
}

buildUserAvatar(LoggedInUser user) {
  return Column(
    children: <Widget>[
      SizedBox(height: 15.0),
      Center(
        child: Container(
          height: 150.0,
          width: 150.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColors[random.nextInt(colousCount)],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Center(
                child: Text(
                  _createInitials(user.fullName),
                  style: TextStyle(fontSize: 50.0, color: Colors.white),
                ),
              ),
              _buldProfPic(user),
            ],
          ),
        ),
      ),
      Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(user.fullName),
          Text(user.email),
        ],
      )
    ],
  );
}
