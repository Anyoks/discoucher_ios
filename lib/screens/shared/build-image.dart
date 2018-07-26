import 'package:flutter/material.dart';

buildItemImage(String featuredImage) {
  // return AssetImage("images/burger.jpg");

  if (featuredImage != null && featuredImage.length > 0) {
    return NetworkImage(featuredImage);
  } else {
    return AssetImage("images/item-placeholder.jpg");
  }
}