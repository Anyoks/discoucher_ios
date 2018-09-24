import 'package:discoucher/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget svgIcon(path) {
  // return new SvgPicture.asset(path);
  return SvgPicture.network("https://raw.githubusercontent.com/dnfield/flutter_svg/master/example/assets/w3samples/alphachannel.svg");
}
