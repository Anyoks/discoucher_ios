import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/details/establishment.dart';
import 'package:flutter/material.dart';

openEstablishmentDetails(BuildContext context, Datum data) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (BuildContext context) {
      return EstablishmentPage(
        data: data,
      );
    }),
  );
}

buildItemImage(String featuredImage) {
  return AssetImage("images/burger.jpg");

  // if (featuredImage != null && featuredImage.length > 0) {
  //   return NetworkImage(featuredImage);
  // } else {
  //   return AssetImage("images/item-placeholder.jpg");
  // }
}

buildGenericListItem(BuildContext context, Datum data) {
  return Container(
    // color: Colors.redAccent,
    width: 160.0,
    margin: EdgeInsets.only(right: 12.0),
    child: new GestureDetector(
      onTap: () {
        openEstablishmentDetails(context, data);
      },
      child: Hero(
        tag: data.id,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 120.0,
              alignment: Alignment(0.0, 1.0),
              margin: EdgeInsets.only(bottom: 4.0),
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: buildItemImage(data.attributes.featuredImage),
                  )),
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Text(
                  data.attributes.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              child: Text(
                data.attributes.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: 11.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
