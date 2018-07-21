import 'package:discoucher/models/datum.dart';
import 'package:flutter/material.dart';

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
              print("pressed");
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              print("pressed");
            },
            icon: Icon(Icons.favorite_border),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          title: Text(widget.data.attributes.name),
          background: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.data.attributes.logo.length > 0
                    ? widget.data.attributes.logo
                    : null),
              ),
            ),
          ),
        ));
  }

  buildSliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print("pressed");
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('grid item $index'),
            ),
          );
        },
        childCount: 100,
      ),
    );
  }

  buildFixedList() {
    return SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: Text('list item $index'),
          );
        },
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
          buildFixedList()
        ],
      ),
    );
  }
}
