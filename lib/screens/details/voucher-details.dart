import 'package:discoucher/contollers/establishment.dart';
import 'package:discoucher/contollers/favorites.dart';
import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/redeem-dialog.dart';
import 'package:discoucher/screens/details/sliver-app-bar.dart';
import 'package:discoucher/screens/details/sliver-list-placeholder.dart';
import 'package:discoucher/screens/details/sliver-list.dart';
import 'package:flutter/material.dart';

class VoucherDetailsPageRoute extends MaterialPageRoute {
  VoucherDetailsPageRoute(VoucherData voucherData)
      : super(builder: (context) => VoucherDetailsPage(voucherData: voucherData));

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class VoucherDetailsPage extends StatefulWidget {
  VoucherDetailsPage({Key key, @required this.voucherData}) : super(key: key);
  final VoucherData voucherData;

  @override
  _VoucherDetailsPageState createState() => new _VoucherDetailsPageState();
}

class _VoucherDetailsPageState extends State<VoucherDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color primaryColor;
  EstablishmentFull _establishmentFull;
  Voucher _voucher = new Voucher();
  EstablishmentController _controller = new EstablishmentController();
  FavoritesController _favoritesController = new FavoritesController();

  @override
  initState() {
    super.initState();
    _voucher = widget.voucherData.attributes;

    fetchEstablishmentDetails();
  }

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            buildSliverAppBar(
              context: context,
              voucher: _voucher,
              est: _establishmentFull,
              addFavorite: () {
                addFavorite();
              },
            ),
            _establishmentFull == null
                ? buildSliverListPlaceHolder(context, _voucher)
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
            showRedeemDialog(context, widget.voucherData.attributes);
          },
          label: const Text('Redeem'),
          icon: Image.asset(
            "images/process/scissors-white.png",
            height: 24.0,
          ),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  void fetchEstablishmentDetails() async {
    var est = await _controller.getEstablishement(widget.voucherData.attributes.establishment.data.id);

    print(est.toJson());

    if (this.mounted) {
      setState(() {
        if (est != null) {
          _establishmentFull = est;
        }
      });
    }
  }

  addFavorite() async {
    final bool addFavResults =
        await _favoritesController.addFavorite(widget.voucherData);
    addFavResults == true
        ? _showMessage("Voucher added to favorites successfully")
        : _showMessage("There was an error adding voucher to favorites");
  }

  void _showMessage(String message, [MaterialColor color = Colors.orange]) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: new Text(message),
      ),
    );
  }
}
