import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/redeem.dart';
import 'package:discoucher/screens/details/successful_redemption.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/utils/customShowDialog.dart';

showRedeemDialog(BuildContext context, Voucher voucher) {
  return showDialog(
    //  barrierDismissible: true,

    context: context,
    builder: (context) {
      return CustomAlertDialog(
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Close',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 17.0),
                ),
              ),
            ),
          ],
          content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
            RedeemPage(
              voucher: voucher,
            ),
          ]))
          // content: Container(
          //   width: MediaQuery.of(context).size.width, //* 0.9,
          //   height: MediaQuery.of(context).size.height * 0.6,
          //   child: ListView(
          //     children: <Widget>[
          //       RedeemPage(
          //         voucher: voucher,
          //       ),
          //     ],
          //   ),
          // ), //SuccessfulRedemptionPage( voucher: voucher,),
          );
    },
  );
}
