import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:flutter/material.dart';

buildEstablishmentDescription(Voucher voucher) {
  return Container(
    padding: EdgeInsets.all(12.0),
    child: Text.rich(
      TextSpan(
        text: voucher.establishment.data.attributes.name,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          normalText(" "),
          TextSpan(
              text: voucher.description,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal)),
          normalText("\n"),
          normalText("\n"),
        ],
      ),
    ),
  );
}
