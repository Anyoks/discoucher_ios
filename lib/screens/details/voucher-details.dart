import 'package:discoucher/contollers/establishment-controller.dart';
import 'package:discoucher/contollers/favorites-controller.dart';
import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/authentication/pay_prompt.dart';
import 'package:discoucher/screens/details/redeem-dialog.dart';
import 'package:discoucher/screens/details/sliver-app-bar.dart';
import 'package:discoucher/screens/details/sliver-list-placeholder.dart';
import 'package:discoucher/screens/details/sliver-list.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';

class VoucherDetailsPageRoute extends MaterialPageRoute {
  VoucherDetailsPageRoute(VoucherData voucherData)
      : super(
            builder: (context) => VoucherDetailsPage(voucherData: voucherData));

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class VoucherDetailsPage extends StatefulWidget {
  VoucherDetailsPage({Key key, @required this.voucherData, this.user})
      : super(key: key);
  final VoucherData voucherData;
  final LoggedInUser user;

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
  DiscoucherRoutes routes = new DiscoucherRoutes();
  LoggedInUser user;
  int counter = 0;

  @override
  initState() {
    super.initState();
    _voucher = widget.voucherData.attributes;

    fetchEstablishmentDetails();
    getuser();
  }

  void getuser() async {
    await controller.checkLoggedIn().then((data) {
      if (this.mounted) {
        if (data != null) {
          setState(() {
            user = data;
          });
        } else {
          // check again because the first check always retursn null
          // this is a work around.
          if (counter < 2) {
            counter++;
            getuser();
          } else {
            counter = 0;
            // setState(() {
            //   error.text = "User not Logged IN";
            // });
          }
        }
      }
    });
  }

  _processRedemption(LoggedInUser user) {
    Voucher voucher = widget.voucherData.attributes;
    if (user != null) {
      // check if they have valid vouchers
      if (user.vouchers == 'valid' || user.vouchers == 'free') {
        // redeem
        print(user.vouchers);
        showRedeemDialog(context, voucher);
      } else {
        // send pay prompt
        Navigator.push(context, PayPromptRoute(user));
      }
    } else {
      // send them to settings page to log in
      routes.go(context, "LoginPage");
    }
  }

  @override
  Widget build(BuildContext context) {
    // getuser();
    primaryColor = Theme.of(context).primaryColor;
    print(user.fullName);
    return buildRedeem(context, user);
  }

  Widget buildRedeem(BuildContext context, LoggedInUser user) {
    // print(widget.user);
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
            _processRedemption(user);
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
    var est = await _controller
        .getEstablishement(widget.voucherData.attributes.establishment.data.id);

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
