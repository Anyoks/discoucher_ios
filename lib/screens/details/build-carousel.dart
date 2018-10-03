import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

buildCarousel(List<String> pictures) {
  return Container(
      height: 150.0,
      width: 300.0,
      foregroundDecoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.black.withOpacity(0.15),
        backgroundBlendMode: BlendMode.darken,
      ),
      child: new Carousel(
        autoplay: false,
        dotSize: 4.0,
        dotSpacing: 15.0,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        dotColor: Colors.white,
        images: pictures.map((url) {
          return NetworkImage(url);
        }).toList(),
      ));
}

class Expanded {}
