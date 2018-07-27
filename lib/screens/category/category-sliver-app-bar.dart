import 'package:flutter/material.dart';

buildCategorySliverAppBar(BuildContext context, String type) {
// - images/establishments/hotels.jpeg
// - images/establishments/hotels2.jpg
// - images/establishments/restaurants.jpeg
// - images/establishments/ribs.jpg
// - images/establishments/salons.jpg
  String img = "images/establishments/mister.jpg";
  switch (type) {
    case "Restaurants":
      img = "images/establishments/restaurants.jpeg";
      break;
    case "Hotels":
      img = "images/establishments/hotels2.jpg";
      break;
    case "Spas and Salons":
      img = "images/establishments/salons.jpg";
      break;
    default:
      img = "images/establishments/hotels.jpeg";
  }

  return SliverAppBar(
    // centerTitle: true,
    pinned: true,
    primary: true,
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
          new AlertDialog(
            title: Text("Title"),
            content: new Text("Test"),
          );

          //  new SimpleDialogOption(
          //   onPressed: () {
          //     print("Dialog pressed");
          //   },
          //   child: new Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: <Widget>[
          //       new Icon(Icons.dialpad, size: 36.0),
          //       new Padding(
          //         padding: const EdgeInsets.only(left: 16.0),
          //         child: new Text("text"),
          //       ),
          //     ],
          //   ),
          // );
        },
        icon: Icon(Icons.settings_applications),
      )
    ],
    flexibleSpace: FlexibleSpaceBar(
      title: Text(type),
      background: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.overlay)),
        ),
      ),
    ),
  );
}
