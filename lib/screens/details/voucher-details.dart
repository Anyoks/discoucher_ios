import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/map.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

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
          buildSliberAppBar(context),
          //buildSliverList(context)
          buildSliverContent(context),
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
            content: Text(widget.data.establishment.data.attributes.area),
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

  buildSliberAppBar(BuildContext context) {
    return SliverAppBar(
        centerTitle: true,
        pinned: true,
        expandedHeight: 200.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //TODO: Add proper sharing
              // Share.share(widget.data.attributes.name);
              final RenderBox box = context.findRenderObject();
              Share.share(widget.data.establishment.data.attributes.name,
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              // TODO: Add proper favorites

              Duration timeout = new Duration(seconds: 3);
              final snackBar = SnackBar(
                duration: timeout,
                content: Text(
                    "${widget.data.establishment.data.attributes.name} added to favorites"),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            },
            icon: Icon(Icons.favorite_border),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          title: Text(widget.data.establishment.data.attributes.name),
          background: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    widget.data.establishment.data.attributes.featuredImage ??
                        "images/item-placeholder.jpg"),
              ),
            ),
          ),
        ));
  }

  buildSliverList(BuildContext context) {
    final voucher = widget.data;

    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        new SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                Center(
                  child: Hero(
                    tag: voucher.heroId,
                    child: Text(
                      voucher.description.toUpperCase(),
                      style: TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                   voucher.condition,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                buildEstablishmentItem(Icons.info,
                    "Only the equal or lesser costing item is free"),
                buildEstablishmentItem(
                    Icons.calendar_today, "Valid only on Tuesday to Friday"),
                buildEstablishmentItem(
                    Icons.local_dining, "About Thyme Main Course Menu"),
                buildEstablishmentItem(Icons.location_on, voucher.establishment.data.attributes.location ),
                buildEstablishmentItem(Icons.phone, voucher.establishment.data.attributes.location ),
                buildEstablishmentItem(Icons.info, "http://about-thyme.com"),
                buildEstablishmentDescription(voucher),
                MapWidget("locationString"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  buildSliverContent(BuildContext context) {
    final voucher = widget.data;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListView(children: <Widget>[
            // Divider(color: Colors.grey),
            // SizedBox(height: 10.0),
            Center(
              child: Hero(
                tag: voucher.heroId,
                child: Text(
                  "FREE LUNCH MAIN COURSE".toUpperCase(),
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(
                "When a Lunch Main Course is bought (a la carte menu only).",
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
            buildEstablishmentItem(
                Icons.info, "Only the equal or lesser costing item is free"),
            buildEstablishmentItem(
                Icons.calendar_today, "Valid only on Tuesday to Friday"),
            buildEstablishmentItem(
                Icons.local_dining, "About Thyme Main Course Menu"),
            buildEstablishmentItem(Icons.phone, "0721 850026"),
            buildEstablishmentItem(Icons.info, "http://about-thyme.com"),

            buildEstablishmentDescription(voucher),
            MapWidget("locationString"),
          ]);
        },
        childCount: 1,
      ),
    );
  }

  buildEstablishmentItem(IconData icon, String title) {
    return Column(
      children: <Widget>[
        SizedBox(width: 10.0),
        Row(
          children: <Widget>[
            SizedBox(width: 15.0),
            Icon(icon, color: primaryColor),
            SizedBox(width: 15.0),
            Text(
              title,
              style: TextStyle(color: xSubtitileColor),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 15.0)
          ],
        ),
        SizedBox(width: 10.0),
        Divider(color: Colors.green),
      ],
    );
  }

  buildEstablishmentDescription(Voucher voucher) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Text.rich(
        TextSpan(
          text: voucher.establishment.data.attributes.name,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            normalText(" "),
            TextSpan(
                text: voucher.description,
                style:
                    TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal)),
            normalText("\n"),
            normalText("\n"),
          ],
        ),
      ),
    );
  }
}
