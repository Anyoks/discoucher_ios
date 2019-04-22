import 'dart:async';

import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/favorites-controller.dart';
import 'package:discoucher/loader/loader.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/category/category-sliver-grid.dart';
import 'package:discoucher/screens/category/category-sliver-list.dart';
import 'package:discoucher/screens/home/home-list-error.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:discoucher/screens/shared/generic-list-item.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FavoritesRoute extends MaterialPageRoute {
  FavoritesRoute() : super(builder: (context) => FavoritesPage());
}

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoritesController _favoritesController = new FavoritesController();
  Future<List<VoucherData>> _favoritesFuture;
  List<VoucherData> favourites;
  bool loading;

  @override
  void initState() {
    loading = true;
    _favoritesFuture = _favoritesController.getFavorites();

    getfavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: AppBackButton(),
          title: AppBarTitle(appBarFavorites),
        ),
        body:  buildFavoritesFuture());//loading ? Center( child: Loader()) : buildFavoritesFuture2());
  }

  buildFavoritesFuture2() {
    return CustomScrollView(
      slivers: <Widget>[
        // print("in here");
        buildCategorySliverList(favourites),
      ],
    );
  }

  getfavourites() async {
    var favs = await _favoritesController.getFavorites();

    setState(() {
      favourites = favs;
      loading = false;
      print("*******");
      // print(favourites.length);
      print("*******");
    });
    return favs;
  }

  buildFavoritesFuture() {
    return FutureBuilder(
      future: _favoritesFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return HomeError(
                onPressed: () {
                  handleRefresh();
                },
                message: "You are offline");
          case ConnectionState.waiting:
            return Container(
              child: Center(child: Loader()),
            );
          case ConnectionState.active:
            return CustomScrollView(slivers: <Widget>[
              buildCategorySliverList(snapshot.data),
            ]);
          case ConnectionState.done:
            if (snapshot.data == null) {
              // NO internet connection
              return HomeError(
                onPressed: () {
                  handleRefresh();
                },
                message: "Please Check your connection. Pull to refresh",
              );
            } else if (snapshot.data.length == 0) {
              print(snapshot.hasData);
              return _nofavoritesYet(context);
            } else if (snapshot.hasError) {
              return HomeError(
                onPressed: () {
                  handleRefresh();
                },
                message: "An error occured. Pull to refresh",
              );
            } else {
              return RefreshIndicator(
                onRefresh: handleRefresh,
                child: CustomScrollView(slivers: <Widget>[
                buildCategorySliverList(snapshot.data),
              ]),
              );
            }
        }
      },
    );
  }

  _nofavoritesYet(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 100.0),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.favorite_border,
                    size: 100.0, color: Colors.blueGrey.withOpacity(0.8)),
                SizedBox(height: 30.0),
                Text("No Favourites!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0)),
                SizedBox(height: 30.0),
                Text("You have not added any favourites.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0)),
                Text("Click on the heart icon within a deal to add one!.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildFavorites(List<VoucherData> _voucherDataList) {
    return ListView.builder(
      key: new Key(new Uuid().v1()),
      scrollDirection: Axis.vertical,
      itemCount: _voucherDataList.length,
      itemBuilder: (BuildContext context, int index) {
        return buildGenericListItem(context, _voucherDataList[index]);
      },
    );
  }

  _buildFavorites2(List<VoucherData> _voucherDataList) {
    return buildCategorySliverList(_voucherDataList);
    //  ListView.builder(
    //         key: new Key(new Uuid().v1()),
    //         scrollDirection: Axis.horizontal,
    //         itemCount: _voucherDataList.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return buildCategorySliverGrid2( _voucherDataList);
    //         },
    //       );
  }

  Future<List<VoucherData>> handleRefresh() async {
    Future<List<VoucherData>> favsFuture = _favoritesController.getFavorites();

    setState(() {
      _favoritesFuture = favsFuture;
    });

    return _favoritesFuture;
  }
}
