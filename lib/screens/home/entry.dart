import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainSection = new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new IconButton(
            splashColor: Colors.redAccent,
            onPressed: () => Navigator.of(context).pushNamed('/tutorial'),
            icon: new Icon(Icons.home),
          )
        ],
      ),
    );

    return new Scaffold(
        appBar: new AppBar(
          // backgroundColor: Colors.white,
          // toolbarOpacity: 0.0,
          // elevation: 0.0,
          title: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
            child: new Image.asset('images/logo.png'),
          ),
          actions: <Widget>[
            new IconButton(
              onPressed: () => {},
              padding: new EdgeInsets.all(2.0),
              icon: new Icon(Icons.notifications),
            ),
          ],
        ),
        body: mainSection);
  }
}
