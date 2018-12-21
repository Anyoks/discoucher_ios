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
      body: _noRedeemedOffersYet(),
    );
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
