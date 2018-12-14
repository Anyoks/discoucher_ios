import 'package:discoucher/constants/colors.dart';
import 'package:flutter/material.dart';

normalText(text) {
  return TextSpan(text: text, style: TextStyle(fontSize: 16.0));
}

greenText(text) {
  return TextSpan(
      text: text, style: TextStyle(fontSize: 16.0, color: xDiscoucherGreen));
}

boldGreenText(text) {
  return Text(
    text,
    style: TextStyle(
        color: xDiscoucherGreen, fontWeight: FontWeight.bold, fontSize: 18.0),
  );
}

boldGreenTitleText(text) {
  return Text(
    text,
    style: TextStyle(
        color: xDiscoucherGreen, fontWeight: FontWeight.bold, fontSize: 24.0, fontFamily: 'Futura'),
  );
}
