import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/category/category-sliver-app-bar.dart';
import 'package:discoucher/screens/category/category-sliver-list.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, @required this.category, @required this.type})
      : super(key: key);
  final List<VoucherData> category;
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
      body: CustomScrollView(
        slivers: <Widget>[
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

}
