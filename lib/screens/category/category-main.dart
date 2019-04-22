import 'dart:async';

import 'package:discoucher/contollers/home-controller.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/category/category-sliver-app-bar.dart';
import 'package:discoucher/screens/category/category-sliver-list.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, @required this.category, @required this.type})
      : super(key: key);
  List<VoucherData> category;
  final String type;

  @override
  _CategoryPageState createState() => new _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _homeController = new HomeController();

  List<VoucherData> _categoryFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

   Future <void> handleRefresh() async {
    
      // _homeFuture = _homeController.fetchHomeData();
       await _homeController.fetchCategoryDataV2(widget.type.toLowerCase()).then((voucherList){
        setState(() {
           widget.category = voucherList;   
        });
      });
      
      // _getCategories();
   

    // return _homeFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: CustomScrollView(
        slivers: <Widget>[
          buildCategorySliverAppBar(
              context: context, type: widget.type, showFiltersFn: openFilters, triggerSearchFn: showSearch),
          buildCategorySliverList(widget.category),
        ],
      ),
      )
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
