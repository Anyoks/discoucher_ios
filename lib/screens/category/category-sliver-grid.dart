import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/shared/generic-list-item.dart';
import 'package:flutter/material.dart';

buildCategorySliverGrid(List<Datum> establishments) {
  return SliverGrid(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    ),
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        var data = establishments[index];
        return Center(
          child: GestureDetector(
            onTap: () {
              openEstablishmentDetails(context, data);
            },
            child: buildCategoryListItem(context, data),
          ),
        );
      },
      childCount: establishments.length,
    ),
  );
}

buildCategoryListItem(BuildContext context, Datum data) {
  return Container(
    margin: EdgeInsets.all(10.0),
    child: Hero(
      tag: data.id,
      child: Column(
        children: <Widget>[
          buildSectonContent(data),
          SizedBox(height: 7.0),
          Expanded(
            child: Text(
              // data.attributes.name,
              "FREE LUNCH MAIN COURSE when a Lunch Main Course",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(color: Colors.black, fontSize: 11.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
