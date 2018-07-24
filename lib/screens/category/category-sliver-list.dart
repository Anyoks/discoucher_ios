import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/details/establishment.dart';
import 'package:discoucher/screens/shared/build-image.dart';
import 'package:flutter/material.dart';

openEstablishmentDetails(BuildContext context, Datum data) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return EstablishmentPage(data: data);
  }));
}

buildCategorySliverList(List<Datum> establishments) {
  return SliverFixedExtentList(
    itemExtent: 120.0,
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
  final double xHeight = 157.0;
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      // borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    // height: xHeight,
    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    margin: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      children: <Widget>[
        //buildSectonContent(data),
        Container(
          height: 157.0,
          width: 160.0,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: buildItemImage(data.attributes.featuredImage),
            ),
          ),
        ),
        SizedBox(width: 7.0),
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
  );
}

buildSectonContent(Datum data) {
  final double xInnerHeight = 150.0;
  return Container(
    height: xInnerHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      shape: BoxShape.rectangle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: buildItemImage(data.attributes.featuredImage),
      ),
    ),
    child: Container(
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
      ),
      child: Container(
        alignment: Alignment(0.0, 1.0),
        constraints: BoxConstraints.expand(height: 44.0),
        padding: EdgeInsets.all(4.0),
        child: Text(
          data.attributes.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
