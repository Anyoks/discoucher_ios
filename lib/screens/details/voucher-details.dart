import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/sliver-app-bar.dart';
import 'package:discoucher/screens/details/sliver-list.dart';
import 'package:discoucher/screens/redemption/redemptions.dart';
import 'package:flutter/material.dart';

class VoucherDetailsPageRoute extends MaterialPageRoute {
  VoucherDetailsPageRoute(Voucher data)
      : super(builder: (context) => VoucherDetailsPage(data: data));

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class VoucherDetailsPage extends StatefulWidget {
  VoucherDetailsPage({Key key, @required this.data}) : super(key: key);
  final Voucher data;

  @override
  _VoucherDetailsPageState createState() => new _VoucherDetailsPageState();
}

class _VoucherDetailsPageState extends State<VoucherDetailsPage> {
  Color primaryColor;

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            buildSliverAppBar(context, widget.data),
            buildSliverList(context, widget.data),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          tooltip: 'Redeem this offer',
          onPressed: () {
            showRedeemDialog(context);
          },
          label: const Text('Redeem'),
          icon: const Icon(Icons.check),
          // icon: svgIcon("images/svg/scissors.svg"),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  showRedeemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: RedemptionsPage(widget.data),
            actions: <Widget>[
              new FlatButton(
                child: Text(
                  "Done",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }
}
