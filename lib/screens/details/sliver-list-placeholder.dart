import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/establishment-item.dart';
import 'package:flutter/material.dart';

buildSliverListPlaceHolder(BuildContext context, Voucher voucher) {
  final establishment = voucher.establishment.data.attributes;

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
        buildEstablishmentItem(Icons.info, voucher.condition),
        buildEstablishmentItem(
            Icons.map, "${establishment.area}, ${establishment.location}"),
        SizedBox(height: 80.0),
        Image.asset("images/loading.gif"),
        SizedBox(height: 80.0),
      ],
    ),
  );
}
