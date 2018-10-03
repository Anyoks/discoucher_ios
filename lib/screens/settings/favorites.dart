import 'dart:async';

import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/favorites-controller.dart';
import 'package:discoucher/models/voucher-data.dart';
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

  @override
  void initState() {
    _favoritesFuture = _favoritesController.getFavorites();

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
        body: buildFavoritesFuture());
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
              child: Center(child: CircularProgressIndicator()),
            );
          default:
            if (snapshot.hasError)
              return HomeError(
                onPressed: () {
                  handleRefresh();
                },
                message: "An error occured. Pull to refresh",
              );
            else if (!snapshot.hasData) {
              return _nofavoritesYet(context);
            } else {
              return _buildFavorites(snapshot.data);
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
    return  ListView.builder(
            key: new Key(new Uuid().v1()),
            scrollDirection: Axis.horizontal,
            itemCount: _voucherDataList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildGenericListItem(context, _voucherDataList[index]);
            },
          );
  }
  
  Future<List<VoucherData>> handleRefresh() async {
    Future<List<VoucherData>> favsFuture = _favoritesController.getFavorites();

    setState(() {
      _favoritesFuture = favsFuture;
    });

    return _favoritesFuture;
  }
}
