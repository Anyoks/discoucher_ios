import 'package:discoucher/constants/api-key.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:discoucher/screens/theme.dart';
import 'package:discoucher/screens/routes.dart';
// import 'package:map_view/map_view.dart';

void main() {
  // MapView.setApiKey(APIKEY);

  runApp(new DiscoucherApp());
}

class DiscoucherApp extends StatelessWidget {
  // static FirebaseAnalytics analytics = new FirebaseAnalytics();
  // static FirebaseAnalyticsObserver observer =
      // new FirebaseAnalyticsObserver(analytics: analytics);

  final DiscoucherTheme _discoucherTheme = new DiscoucherTheme();
  final DiscoucherRoutes _discoucherRoutes = new DiscoucherRoutes();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Discoucher',
      theme: _discoucherTheme.theme,
      home: _discoucherRoutes.splashScreen,
      // navigatorObservers: <NavigatorObserver>[observer],
      routes: _discoucherRoutes.routes,
    );
  }
}
