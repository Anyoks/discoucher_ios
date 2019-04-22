import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/favorites-controller.dart';
import 'package:discoucher/loader/loader.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/category/category-sliver-list.dart';
import 'package:discoucher/screens/home/home-list-error.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:flutter/material.dart';

class RedeemedOffersRoute extends MaterialPageRoute {
  RedeemedOffersRoute() : super(builder: (context) => RedeemedOffers());
}

class RedeemedOffers extends StatefulWidget {
  @override
  _RedeemedOffersState createState() => _RedeemedOffersState();
}

class _RedeemedOffersState extends State<RedeemedOffers> {
  FavoritesController _favoritesController = new FavoritesController();
  // Future<List<VoucherData>> _favoritesFuture;
  List<VoucherData> redeemedOffers;
  Future<List<VoucherData>> _favoritesFuture;

  bool loading;

  @override
  void initState() {
    // getfavourites();
    loading = true;
    _favoritesFuture = _favoritesController.getRedeemedOffers();
    super.initState();
  }

  void getfavourites() async {
    var favs = await _favoritesController.getRedeemedOffers();

    setState(() {
      redeemedOffers = favs;
      loading = false;
      print("*******");
      // print(favourites.length);
      print("*******");
    });
    // return favs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: AppBackButton(),
          title: AppBarTitle(appBarRedeemedOffers),
        ),
        body:
            buildFavoritesFuture() //loading ?  Center( child: Loader()) : ( redeemedOffers.length > 0 ? buildFavoritesFuture2()  : _noRedeemedOffersYet()),
        );
  }

  buildFavoritesFuture2() {
    return CustomScrollView(
      slivers: <Widget>[
        // print("in here");
        buildCategorySliverList(redeemedOffers),
      ],
    );
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
              return _noRedeemedOffersYet();
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
        return _noRedeemedOffersYet();
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

  _noRedeemedOffersYet() {
    return Center(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 100.0),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.receipt,
                    size: 100.0, color: Colors.blueGrey.withOpacity(0.8)),
                SizedBox(height: 30.0),
                Text("No Redeemed Deals Yet!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0)),
                SizedBox(height: 30.0),
                Container(
                  child: Text(
                      "Visit any of our over 100 registered establishements and buy one, get one free!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
