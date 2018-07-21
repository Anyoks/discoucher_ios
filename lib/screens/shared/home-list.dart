import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/shared/generic-list-item.dart';
import 'package:discoucher/screens/shared/home-section-title.dart';
import 'package:flutter/material.dart';

buildHomeList(BuildContext context, List<Datum> data) {
  return new Container(
    margin: EdgeInsets.only(left: 12.0, top: 12.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildHomeSectionTitle(context, data[1].type),
        Container(
          height: 154.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              buildGenericListItem(context, data[1], "images/burger.jpg"),
              buildGenericListItem(
                  context, data[2], "images/establishments/mayura.jpg"),
              buildGenericListItem(
                  context, data[3], "images/establishments/mister.jpg"),
              buildGenericListItem(
                  context, data[1], "images/establishments/ob.jpg"),
              buildGenericListItem(
                  context, data[4], "images/establishments/platter.png"),
            ],
          ),
        ),
      ],
    ),
  );
}
