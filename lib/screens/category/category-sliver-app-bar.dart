import 'dart:async';

import 'package:discoucher/contollers/search-delegate.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/details/voucher-details.dart';
import 'package:flutter/material.dart';

final _searchDelegate = SearchDiscoucherSearchDelegate();

Future openSearch(BuildContext context) async {
  final VoucherData selected = await showSearch<VoucherData>(
    context: context,
    delegate: _searchDelegate,
  );

  if (selected != null) {
    Navigator.push(context, VoucherDetailsPageRoute(selected.attributes));
  }
}

buildCategorySliverAppBar({
  BuildContext context,
  String type,
  Function showFiltersFn,
  Function triggerSearchFn,
}) {
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
    expandedHeight: 120.0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
    ),
    title: _buildSearchTrigger(context, type, triggerSearchFn),
    flexibleSpace: FlexibleSpaceBar(
      background: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
      ),
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () => showFiltersFn(),
        icon: Icon(Icons.tune),
      )
    ],
  );
}

Widget _buildSearchTrigger(
    BuildContext context, String type, Function triggerSearchFn) {
  return GestureDetector(
    onTap: () {
      // triggerSearchFn();
      openSearch(context);
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 5.0),
          alignment: Alignment(0.0, 0.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10.0),
              Icon(Icons.search, color: Colors.white),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  "Search in ${type.toLowerCase()}",
                  style: TextStyle(fontSize: 16.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 15.0)
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(right: 0.0),
            height: 1.0,
            color: Colors.white),
      ],
    ),
  );
}
