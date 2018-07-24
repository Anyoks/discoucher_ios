import 'package:discoucher/contollers/categories.dart';
import 'package:discoucher/screens/home/horizontal-list.dart';
import 'package:flutter/material.dart';

buildRestaurantsSection(BuildContext context) {
  return FutureBuilder(
    future: fetchCategory(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return Container(
            height: 191.0,
              // color: Colors.amber,
              child: Center(child: CircularProgressIndicator(),)
              );
        default:
          if (snapshot.hasError)
            return new Text('An error happened');
          else
            return buildHomeList(context, snapshot.data);
      }
    },
  );
}

buildHotelsSection(BuildContext context) {
  //return buildHomeList(context, dummyBuildData());
  buildRestaurantsSection(context);
}

buildSpasAndSalonsSection(BuildContext context) {
  //return buildHomeList(context, dummyBuildData());
  buildRestaurantsSection(context);
}

buildOutCountrySection(BuildContext context) {
  //return buildHomeList(context, dummyBuildData());
  buildRestaurantsSection(context);
}
