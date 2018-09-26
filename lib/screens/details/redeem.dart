import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:flutter/material.dart';

class RedeemPage extends StatelessWidget {
  RedeemPage(this.voucher);
  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset("images/process/redeem.png", height: 40.0),
              SizedBox(width: 17.0),
              boldGreenText("Redeem"),
            ],
          ),
        ),
        Divider(color: Colors.green[900]),
        SizedBox(height: 10.0),
        Text("Show the following codes:"),
        SizedBox(height: 20.0),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildRedeemSection(
                  Icons.chrome_reader_mode, "Book code:", "code"),
              SizedBox(height: 20.0),
              buildRedeemSection(
                  Icons.bookmark_border, "Voucher code:", "${voucher.code}")
            ],
          ),
        )
      ],
    );
  }

  buildRedeemSection(IconData icon, String title, String code) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 30.0,
              color: xDiscoucherGreen,
            ),
            SizedBox(width: 20.0),
            Flexible(
              child: boldGreenText(code),
            )
          ],
        )
      ],
    );
  }
}
