import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/shared/generic-list-item.dart';
import 'package:discoucher/screens/shared/home-section-title.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

buildHomeList(BuildContext context, List<Datum> data) {
  return new Container(
    margin: EdgeInsets.only(left: 12.0, top: 12.0),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildHomeSectionTitle(context, data[1].type),
        Container(
          height: 154.0,
          child: ListView.builder(
            key: new Key(new Uuid().v1()), //new,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return buildGenericListItem(context, data[index]);
            },
          ),
        ),
      ],
    ),
  );
}
