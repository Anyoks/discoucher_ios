import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/category/category-sliver-app-bar.dart';
import 'package:discoucher/screens/category/category-sliver-grid.dart';
import 'package:discoucher/screens/category/category-sliver-list.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, @required this.category, @required this.type})
      : super(key: key);
  final List<Datum> category;
  final String type;

  @override
  _CategoryPageState createState() => new _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isGridVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildCategorySliverAppBar(context, widget.type),
          buildListTypeSelector(),
          isGridVisible
              ? buildCategorySliverGrid(widget.category)
              : buildCategorySliverList(widget.category),
        ],
      ),
    );
  }

  buildListTypeSelector() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        childAspectRatio: 3.0
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
           /// color: Colors.red,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  tooltip: 'Grid view',
                  icon: Icon(Icons.grid_on, color: Colors.green[900]),
                  onPressed: () {
                    setState(() {
                      isGridVisible = true;
                    });
                  },
                ),
                IconButton(
                  tooltip: 'List view',
                  icon: Icon(Icons.list, color: Colors.green[900]),
                  onPressed: () {
                    setState(() {
                      isGridVisible = false;
                    });
                  },
                ),
                Center(child: Text("")),
              ],
            ),
          );
        },
        childCount: 1,
      ),
    );
  }
}
