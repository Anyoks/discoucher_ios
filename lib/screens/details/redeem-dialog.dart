import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/redeem.dart';
import 'package:discoucher/screens/details/successful_redemption.dart';
import 'package:flutter/material.dart';

showRedeemDialog(BuildContext context, Voucher voucher) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          content: //SuccessfulRedemptionPage( voucher: voucher,),
          RedeemPage(
            voucher: voucher,
          ),
          // actions: <Widget>[
          //   new FlatButton(
          //     child: Text(
          //       "Done",
          //       style: TextStyle(color: Theme.of(context).primaryColor),
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ]
          );
    },
  );
}
