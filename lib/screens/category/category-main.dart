
import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/category/category-sliver-app-bar.dart';
import 'package:discoucher/screens/category/category-sliver-grid.dart';
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
      // appBar: new AppBar(title: new Text("Category")),
      body: CustomScrollView(
        slivers: <Widget>[
          buildCategorySliverAppBar(context, widget.type),
          buildCategorySliverGrid(widget.category),
        ],
      ),
    );
  }
}
