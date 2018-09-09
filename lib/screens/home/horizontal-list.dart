import 'package:discoucher/models/datum.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/home/home-section-title.dart';
import 'package:discoucher/screens/shared/generic-list-item.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

buildHomeList(BuildContext context, List<Voucher> data) {
  var estType = data[0].establishment.data.type != null
      ? data[0].establishment.data.type
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
