import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/establishment.dart';
import 'package:discoucher/screens/shared/build-image.dart';
import 'package:flutter/material.dart';

buildSectionContent(Voucher data) {
  final double xHeight = 120.0;
  final double xWidth = 159.0;
  return Container(
    height: xHeight,
    width: xWidth,
    decoration: new BoxDecoration(
      borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      shape: BoxShape.rectangle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: buildItemImage(data.establishment.data.attributes.featuredImage),
      ),
    ),
    child: Container(
      foregroundDecoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        shape: BoxShape.rectangle,
      ),
      child: Container(
        alignment: Alignment(0.0, 1.0),
        constraints: BoxConstraints.expand(height: 44.0),
        padding: EdgeInsets.all(4.0),
        child: Text(
          data.establishment.data.attributes.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      // DecoratedBox(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //           colors: [
      //             Color(0xff000000).withOpacity(0.4),
      //             Color(0x00000000),
      //           ],
      //           begin: FractionalOffset.bottomCenter,
      //           end: FractionalOffset.topCenter,
      //           stops: [0.0, 0.7]),
      //     ),
      //     child: null
      // Container(
      //   alignment: Alignment(0.0, 1.0),
      //   constraints: BoxConstraints.expand(height: 44.0),
      //   padding: EdgeInsets.all(4.0),
      //   child: Text(
      //     data.attributes.name,
      //     maxLines: 2,
      //     overflow: TextOverflow.ellipsis,
      //     style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 18.0,
      //         fontWeight: FontWeight.w500),
      //     textAlign: TextAlign.center,
      //   ),
      // ),
      // ),
    ),
  );
}

buildGenericListItem(BuildContext context, Voucher data) {
  return Container(
    width: 160.0,
    margin: EdgeInsets.only(right: 10.0),
    child: new GestureDetector(
      onTap: () {
        Navigator.push(context, EstablishmentPageRoute(data));
      },
      child: Column(
        children: <Widget>[
          buildSectionContent(data),
          SizedBox(height: 7.0),
          Expanded(
            child: Hero(
              tag: 'text-${data.establishment.data.id}',
              child: Text(
                // data.attributes.name,
                "FREE LUNCH MAIN COURSE when a Lunch Main Course",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: 11.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
