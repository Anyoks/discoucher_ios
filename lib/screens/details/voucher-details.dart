import 'package:discoucher/contollers/establishment.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/sliver-app-bar.dart';
import 'package:discoucher/screens/details/sliver-list-placeholder.dart';
import 'package:discoucher/screens/details/sliver-list.dart';
import 'package:discoucher/screens/redemption/redemptions.dart';
import 'package:flutter/material.dart';

class VoucherDetailsPageRoute extends MaterialPageRoute {
  VoucherDetailsPageRoute(Voucher data)
      : super(builder: (context) => VoucherDetailsPage(data: data));
}

class VoucherDetailsPage extends StatefulWidget {
  VoucherDetailsPage({Key key, @required this.data}) : super(key: key);
  final Voucher data;

  @override
  _VoucherDetailsPageState createState() => new _VoucherDetailsPageState();
}

class _VoucherDetailsPageState extends State<VoucherDetailsPage> {
  Color primaryColor;
  EstablishmentFull _establishmentFull;
  Voucher _voucher = new Voucher();
  EstablishmentController _controller = new EstablishmentController();

  @override
  initState() {
    super.initState();
    _voucher = widget.data;

    // _establishmentFull = new EstablishmentFull(
    //   name: _voucher.establishment.data.attributes.name,
    //   area: _voucher.establishment.data.attributes.area,
    //   location: _voucher.establishment.data.attributes.location,
    //   featuredImage: _voucher.establishment.data.attributes.featuredImage,
    // );

    fetchEstablishmentDetails();
  }

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            buildSliverAppBar(context, _voucher),
            _establishmentFull == null
                ? buildSliverListPlaceHolder(
                    context,
                    _voucher
                  )
                : buildSliverList(
                    context,
                    _voucher,
                    _establishmentFull,
                  ),
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

  void fetchEstablishmentDetails() async {
    var est =
        await _controller.getEstablishement(widget.data.establishment.data.id);
    setState(() {
      if (est != null) {
        _establishmentFull = est;
      }
    });
  }
}
