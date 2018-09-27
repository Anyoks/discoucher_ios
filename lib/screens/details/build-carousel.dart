import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

buildCarousel(List<String> pictures) {
  return Container(
      height: 150.0,
      width: 300.0,
      child: new Carousel(
        autoplay: false,
        dotSize: 4.0,
        dotSpacing: 15.0,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        overlayShadow: true,
        overlayShadowColors: Colors.grey[800],
        overlayShadowSize: 0.3,
        images: pictures.map((url) {
          return NetworkImage(url);
        }).toList(),
      ));
}

class Expanded {}
