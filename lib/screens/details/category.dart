import 'dart:async';
import 'dart:convert';

import 'package:discoucher/contollers/categories.dart';
import 'package:discoucher/models/datum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, @required this.category}) : super(key: key);
  final String category;

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

  List<Datum> categoryList = [];
  Object apiVersion;
  StreamController<Datum> categoryStreamController;

  loadCategoryList() async {
    http.Response response = await http.get(Uri.encodeFull(restaurantsEndpoint),
        headers: {'Accept': 'application/json'});

    var res = json.decode(response.body);

    var list = res['data'];
    var count = list.length;
    for (int i = 0; i < count; i++) {
      Datum dt = new Datum.fromJson(list[i]);
      print(dt.id);
    }

    setState(() {
      apiVersion = list.length;
    });
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List establishments = snapshot.data;

    return new ListView.builder(
      itemCount: establishments.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(establishments[index].id),
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

    categoryStreamController = StreamController.broadcast();
    categoryStreamController.stream
        .listen((data) => setState(() => print(data)));

    // loadCountriesUsingStream(categoryStreamController);

    // loadCategoryList();
  }

  loadCountriesUsingStream(StreamController sc) async {
    var client = http.Client();
    var req = http.Request('get', Uri.parse(restaurantsEndpoint));
    var streamedResponse = await client.send(req);

    streamedResponse.stream
        .transform(UTF8.decoder)
        .transform(json.decoder)
        .expand((e) => e)
        .map((map) => Datum.fromJson(map))
        .pipe(categoryStreamController);
  }

  buildCategories(int index) {
    if (index >= categoryList.length) {
      return null;
    }

    return Card(
      child: Stack(
        alignment: Alignment(-1.0, 1.0),
        children: <Widget>[
          // Container(
          //   color: Colors.amber[300],
          //   //child: buildSvgImage(categoryList[index].flag),
          // ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                categoryList[index].id,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
        ],
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
        // background: DecoratedBox(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("widget.imageUrl"), fit: BoxFit.cover),
        //   ),
        // ),
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
      future: getCategoryList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return Scaffold(
      appBar: new AppBar(title: new Text("Category")),
      // body: Center(
      //   child: ListView.builder(
      //       itemBuilder: (BuildContext context, int index) =>
      //           buildCategories(index)),
      // ),

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

  @override
  void dispose() {
    super.dispose();
    categoryStreamController?.close();
  }
}
