import 'package:flutter/material.dart';
import 'package:discoucher/screens/home/generic-list.dart';
import 'package:discoucher/screens/home/top-banner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFFE5E5E5),
        elevation: 0.1,
        // toolbarOpacity: 0.0,
        title: new Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
              child: new Image.asset('images/logo.png'),
            ),
          ],
        ),
        actions: <Widget>[
          new IconButton(
            onPressed: () {},
            padding: new EdgeInsets.all(2.0),
            icon: new Icon(Icons.notifications),
          ),
        ],
      ),
       body: ListView(
        children: [
          topBannerSection,
          buildRestaurantsSection(context),
          buildHotelsSection(context),
          buildSpasAndSalonsSection(context),
          buildOutCountrySection(context),
        ],
      ),
    );
  }
}
