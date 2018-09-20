import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/home/home-section-title.dart';
import 'package:discoucher/screens/shared/generic-list-item.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

buildHomeList(BuildContext context, List<Voucher> data, int index) {
  String header = "";
  switch (index) {
    case 0:
      header = "Restaurants";
      break;
    case 1:
      header = "Hotels";
      break;
    case 2:
      header = "Spas and Salons";
      break;
    default:
      header = "Establishments";
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
