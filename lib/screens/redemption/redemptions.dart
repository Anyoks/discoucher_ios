import 'package:discoucher/models/voucher.dart';
import 'package:flutter/material.dart';

class RedemptionsPage extends StatelessWidget {
  RedemptionsPage(this.voucher);
  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Row(
            children: <Widget>[
              Image.asset("images/process/redeem.png", height: 40.0),
              SizedBox(width: 17.0),
              Center(child: Text("Redeem")),
            ],
          ),
        ),
        Divider(color: Colors.green[900]),
        Column(
          children: <Widget>[
            Text("Show the following codes:"),
            buildRedeemSection(Icons.book, "title", "code"),
            buildRedeemSection(Icons.bookmark, "title", "code")
          ],
        )
      ],
    );
  }

  buildRedeemSection(IconData icon, String title, String code) {
    return Column(
      children: <Widget>[
        Text(title),
        Row(
          children: <Widget>[
            Icon(icon, size: 40.0),
            Text(code, style: TextStyle(fontSize: 18.0)),
          ],
        )
      ],
    );
  }
}
