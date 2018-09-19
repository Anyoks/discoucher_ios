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
      body: Center(
        child: Text("Favourites"),
      ),
    );
  }
}
