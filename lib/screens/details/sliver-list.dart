import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/establishment-description.dart';
import 'package:discoucher/screens/details/establishment-item.dart';
import 'package:discoucher/screens/details/map.dart';
import 'package:discoucher/screens/shared/svg-picture.dart';
import 'package:flutter/material.dart';

buildSliverList(BuildContext context, Voucher voucher) {
  return SliverList(
    delegate: SliverChildListDelegate(
      <Widget>[
        Hero(
          tag: voucher.heroId,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
              child: Text(
                voucher.description.toUpperCase(),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        buildEstablishmentItem(
          Icons.info,
          voucher.condition,
        ),
        buildEstablishmentItem(
          Icons.map,
          voucher.establishment.data.attributes.area,
        ),
        buildEstablishmentItem(
          Icons.location_on,
          voucher.establishment.data.attributes.location,
        ),
        voucher.establishment.data.attributes.location != null
            ? MapWidget(
                voucher.establishment.data.attributes.location,
              )
            : Container(),
      ],
    ),
  );
}
