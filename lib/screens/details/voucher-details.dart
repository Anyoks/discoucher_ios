import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/sliver-app-bar.dart';
import 'package:discoucher/screens/details/sliver-list.dart';
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
    return Scaffold(
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
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  showRedeemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Text(widget.data.code),
            title: Text(widget.data.establishment.data.attributes.name),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }
}
