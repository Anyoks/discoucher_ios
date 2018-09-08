import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/details/map.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class EstablishmentPage extends StatefulWidget {
  EstablishmentPage({Key key, @required this.data}) : super(key: key);
  final Datum data;

  @override
  _EstablishmentPageState createState() => new _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage> {
  Color primaryColor;

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildSliberAppBar(context),
          buildSliverContent(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Redeem this offer',
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(widget.data.attributes.area),
                title: Text(widget.data.attributes.name),
              );
            },
          );
        },
        label: const Text('Redeem'),
        icon: const Icon(Icons.check),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
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
              Share.share(widget.data.attributes.name,
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
                content:
                    Text("${widget.data.attributes.name} added to favorites"),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            },
            icon: Icon(Icons.favorite_border),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          title: Text(widget.data.attributes.name),
          background: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.data.attributes.featuredImage ??
                    "images/item-placeholder.jpg"),
              ),
            ),
          ),
        ));
  }

  buildSliverContent(BuildContext context) {
    final establishment = widget.data;

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
              child: Text(
                "FREE LUNCH MAIN COURSE".toUpperCase(),
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
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

            buildEstablishmentDescription(establishment),
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

  buildEstablishmentDescription(Datum establishment) {
    return new RichText(
      text: new TextSpan(
        text: '',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          new TextSpan(
              text: establishment.attributes.name,
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(
              text:
                  'offers an eclectic menu with imaginative, well-prepared and beautifully presented dishes from around the world. There is something to cater for all tastes with a wide range of vegetarian dishes. Our desserts are a special treat and have become famous over the years.'),
        ],
      ),
    );
  }
}
