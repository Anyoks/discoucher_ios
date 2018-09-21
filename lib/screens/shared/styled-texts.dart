import 'package:discoucher/constants/colors.dart';
import 'package:flutter/material.dart';

normalText(text) {
  return TextSpan(text: text, style: TextStyle(fontSize: 16.0));
}

greenText(text) {
  return TextSpan(
      text: text, style: TextStyle(fontSize: 16.0, color: xDiscoucherIconGreen));
}

boldGreenText(text) {
  return Text(
    text,
    style: TextStyle(
        color: xDiscoucherIconGreen, fontWeight: FontWeight.bold, fontSize: 18.0),
  );
}
