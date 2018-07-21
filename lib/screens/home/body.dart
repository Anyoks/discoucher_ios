import 'package:discoucher/screens/home/top-banner.dart';
import 'package:discoucher/screens/shared/generic-list-builder.dart';
import 'package:flutter/material.dart';

buildBody(BuildContext context) {
  return ListView(
    children: [
      topBannerSection,
      buildRestaurantsSection(context),
      buildHotelsSection(context),
      buildSpasAndSalonsSection(context),
      buildOutCountrySection(context),
    ],
  );
}
