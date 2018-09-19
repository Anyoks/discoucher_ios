import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:flutter/material.dart';

class FavoritesRoute extends MaterialPageRoute {
  FavoritesRoute() : super(builder: (context) => Favorites());

  // @override
  // Widget buildTransitions(BuildContext context, Animation<double> animation,
  //     Animation<double> secondaryAnimation, Widget child) {
  //   return FadeTransition(opacity: animation, child: child);
  // }
}

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        title: AppBarTitle(appBarFavorites),
      ),
      body: _nofavoritesYet(context),
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
}
