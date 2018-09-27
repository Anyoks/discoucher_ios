import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/voucher-details.dart';
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
        colorFilter: new ColorFilter.mode(
          Colors.black.withOpacity(0.2),
          BlendMode.darken,
        ),
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
    ),
  );
}

buildGenericListItem(BuildContext context, Voucher data) {
  data.description = data.description.trim().replaceAll("\n", " ");
  return Container(
    width: 160.0,
    margin: EdgeInsets.only(right: 10.0),
    child: new GestureDetector(
      onTap: () {
        Navigator.push(context, VoucherDetailsPageRoute(data));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildSectionContent(data),
          SizedBox(height: 7.0),
          Hero(
            tag: data.heroId,
            child: Text(
              data.description,
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
