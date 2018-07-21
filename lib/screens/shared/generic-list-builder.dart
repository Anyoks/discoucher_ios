import 'package:discoucher/contollers/categories.dart';
import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/shared/home-list.dart';
import 'package:flutter/material.dart';

List<Datum> dummyBuildData() {
  var data;
  fetchCategory().then((list) {
    data = list;
  }).catchError((
    error,
  ) {
    data = error;
  });
  return data;
}

buildRestaurantsSection(BuildContext context) {
  return buildHomeList(context, dummyBuildData());
}

buildHotelsSection(BuildContext context) {
  return buildHomeList(context, dummyBuildData());
}

buildSpasAndSalonsSection(BuildContext context) {
  return buildHomeList(context, dummyBuildData());
}

buildOutCountrySection(BuildContext context) {
  return buildHomeList(context, dummyBuildData());
}
