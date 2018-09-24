import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/establihsment-description.dart';
import 'package:discoucher/screens/details/establishment-item.dart';
import 'package:discoucher/screens/details/map.dart';
import 'package:discoucher/screens/shared/svg-picture.dart';
import 'package:flutter/material.dart';

buildSliverList(BuildContext context, Voucher voucher) {
  return SliverList(
    delegate: SliverChildListDelegate(
      <Widget>[
        Center(
          child: Hero(
            tag: voucher.heroId,
            child: Material(
              type: MaterialType.transparency,
              child: Card(
                margin: EdgeInsets.all(12.0),
                child: Container(
                  child: Text(
                    voucher.description.toUpperCase(),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Text(
            voucher.condition != null ? voucher.condition : "",
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ),

        svgIcon(""),

        buildEstablishmentItem(Icons.info, voucher.description),
        buildEstablishmentItem(Icons.calendar_today,
            voucher.condition != null ? voucher.condition : ""),
        buildEstablishmentItem(
            Icons.local_dining, "About Thyme Main Course Menu"),
        buildEstablishmentItem(Icons.location_on,
            "${voucher.establishment.data.attributes.area}, ${voucher.establishment.data.attributes.location}"),
        buildEstablishmentItem(
            Icons.phone, voucher.establishment.data.attributes.location),
        buildEstablishmentItem(
            Icons.info, voucher.establishment.data.attributes.name),
        buildEstablishmentDescription(voucher),
        MapWidget(voucher.establishment.data.attributes.location),
      ],
    ),
  );
}
