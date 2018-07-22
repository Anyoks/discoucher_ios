import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/shared/generic-list-item.dart';
import 'package:discoucher/screens/shared/home-section-title.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

buildHomeList(BuildContext context, List<Datum> data) {
  var estType = data[0].attributes.estType != null
      ? data[0].attributes.estType
      : "Establishment";

  String header = estType;
  switch (estType) {
    case "Restaurant":
      header = "Restaurants";
      break;
    case "Hotel":
      header = "Hotels";
      break;
    case "Spas and Salons":
      header = "Spas and Salons";
      break;
    default:
      header = estType;
  }
  
  return new Container(
    margin: EdgeInsets.only(left: 12.0, top: 5.0),
    child: Column(
      children: <Widget>[
        buildHomeSectionTitle(
            // TODO: Remove this shinanigan
            context,
            data,
            header),
        Container(
          height: 154.0,
          child: ListView.builder(
            key: new Key(new Uuid().v1()),
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
