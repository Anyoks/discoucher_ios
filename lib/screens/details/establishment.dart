import 'package:discoucher/models/datum.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class EstablishmentPage extends StatefulWidget {
  EstablishmentPage({Key key, @required this.data}) : super(key: key);
  final Datum data;

  @override
  _EstablishmentPageState createState() => new _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage> {
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

  buildSliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(widget.data.attributes.name),
              ),
              SizedBox(height: 200.0),
              Center(
                child: InkWell(
                  onTap: () {
                    print("Inkwell tapped");
                  },
                  splashColor: Colors.purpleAccent,
                  child: Text(
                    "Keep calm! Data is coming here!",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(height: 1000.0),
              ),
            ],
          );
        },
        childCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildSliberAppBar(context),
          buildSliverGrid(),
        ],
      ),
    );
  }
}
