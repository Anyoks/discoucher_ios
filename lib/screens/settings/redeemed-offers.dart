import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:flutter/material.dart';

class RedeemedOffersRoute extends MaterialPageRoute {
  RedeemedOffersRoute() : super(builder: (context) => RedeemedOffers());
}

class RedeemedOffers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        title: AppBarTitle(appBarRedeemedOffers),
      ),
      body: Center(
        child: Text("Redeemed Offers"),
      ),
    );
  }
}
