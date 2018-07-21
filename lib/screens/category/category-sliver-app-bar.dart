import 'package:flutter/material.dart';

buildCategorySliverAppBar(BuildContext context) {
  return SliverAppBar(
    centerTitle: true,
    pinned: true,
    expandedHeight: 200.0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          print("pressed");
        },
        icon: Icon(Icons.share),
      ),
      IconButton(
        onPressed: () {
          print("pressed");
        },
        icon: Icon(Icons.favorite_border),
      )
    ],
    flexibleSpace: FlexibleSpaceBar(
      title: Text("widget.title"),
      // background: DecoratedBox(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage("widget.imageUrl"), fit: BoxFit.cover),
      //   ),
      // ),
    ),
  );
}
