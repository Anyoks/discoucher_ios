import 'package:flutter/material.dart';

Widget _buildSearchTrigger(String type, Function triggerSearchFn) {
  return GestureDetector(
    onTap: () {
      triggerSearchFn();
    },
    child: Stack(
      alignment: Alignment(0.0, 1.0),
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10.0),
              Icon(Icons.search, color: Colors.white),
              SizedBox(width: 10.0),
              Expanded(
                child: Text("Search in ${type.toLowerCase()}",
                    style: TextStyle(fontSize: 16.0),
                    overflow: TextOverflow.ellipsis),
              ),
              SizedBox(width: 15.0)
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(right: 50.0),
            height: 1.0,
            color: Colors.white),
      ],
    ),
  );
}

buildCategorySliverAppBar(
    {BuildContext context,
    String type,
    Function showFiltersFn,
    Function triggerSearchFn}) {
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
    centerTitle: true,
    pinned: true,
    primary: true,
    expandedHeight: 200.0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
    ),
    flexibleSpace: FlexibleSpaceBar(
      title: _buildSearchTrigger(type, triggerSearchFn),
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
    actions: <Widget>[
      IconButton(
        onPressed: () {
          showFiltersFn();
        },
        icon: Icon(Icons.tune),
      )
    ],
  );
}
