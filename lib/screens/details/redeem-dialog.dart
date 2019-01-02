import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/redeem.dart';
import 'package:discoucher/screens/details/successful_redemption.dart';
import 'package:flutter/material.dart';

showRedeemDialog(BuildContext context, Voucher voucher) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView(
            children: <Widget>[
              RedeemPage(
                voucher: voucher,
              ),
            ],
          ),
        ), //SuccessfulRedemptionPage( voucher: voucher,),
      );
    },
  );
}
