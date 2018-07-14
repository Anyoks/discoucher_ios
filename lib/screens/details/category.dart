import 'dart:async';
import 'dart:convert';

import 'package:discoucher/enums/enums.dart';
import 'package:discoucher/models/establishment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, @required this.category}) : super(key: key);
  final EstablishmentType category;

  @override
  _CategoryPageState createState() => new _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final String restaurantsEndpoint =
      "http://46.101.137.125/api/v1/establishments/restaurants";
  final String hotelsEndpoint =
      "http://46.101.137.125/api/v1/establishments/hotels";
  final String spasEndpoint =
      "http://46.101.137.125/api/v1/establishments/spas";

  List<Datum> categoryList;
  StreamController<DiscoucherRoot> categoryStreamController;
  DiscoucherRoot discoucherRoot;

  Future<List<String>> _getData() async {
    var values = new List<String>();
    values.add("Horses");
    values.add("Goats");
    values.add("Chickens");

    //throw new Exception("Danger Will Robinson!!!");

    await new Future.delayed(new Duration(seconds: 5));

    return values;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(values[index]),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // categoryStreamController = StreamController.broadcast();
    // categoryStreamController.stream
    //     .listen((discoucherRoot) => setState(() => category.add(discoucherRoot.data)));
  }

  Future<bool> getCategoryList() async {
    var response = await http.get(Uri.encodeFull(restaurantsEndpoint),
        headers: {'Accept': 'application/json'});

    setState(() {
      categoryList = json.decode(response.body);
    });
    return true;
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
        title: Text("widget.title"),
        background: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("widget.imageUrl"), fit: BoxFit.cover),
          ),
        ),
      ),
    );
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
    var futureBuilder = FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return Scaffold(
      body: futureBuilder,
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     buildSliberAppBar(context),
      //     buildSliverGrid(),
      //     buildFixedList()
      //   ],
      // ),
    );
  }

  static getData() {}
}
