import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/category/category-sliver-app-bar.dart';
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
  final _searchDelegate = SearchController.getDelegate();
  int _lastIntegerSelected;

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
          // buildCategorySliverAppBar(context:context,  widget.type, openFilters),
          buildCategorySliverAppBar(
              context: context, type: widget.type, showFiltersFn: openFilters, triggerSearchFn: showSearch),
          buildCategorySliverList(widget.category),
        ],
      ),
    );
  }

  openFilters() {
    print("Filters");

    // AlertDialog(
    //   title: Text("Title"),
    //   content: new Text("Test"),
    // );
  }

  openSearch() async {
    final int selected = await showSearch<int>(
      context: context,
      delegate: this._searchDelegate,
    );
    if (selected != null && selected != _lastIntegerSelected) {
      setState(() {
        _lastIntegerSelected = selected;
      });
    }
  }
}
