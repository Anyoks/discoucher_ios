import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/successful_redemption.dart';
import 'package:flutter/material.dart';

showSuccessRedeemDialog(BuildContext context, Voucher voucher) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView(children: <Widget>[
              SuccessfulRedemptionPage(
                voucher: voucher,
              ),
            ])),
      );
    },
  );
}
