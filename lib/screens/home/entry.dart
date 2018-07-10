import 'package:flutter/material.dart';

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
    Widget topBannerSection = Container(
      color: Colors.red,
      child: SizedBox(
        height: 173.0,
        child: new Image.asset("images/banner.jpg", fit: BoxFit.cover),
      ),
    );

    Widget restaurantsList = Container(
      padding: EdgeInsets.only(left: 12.0),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () => {},
                  child: Text(
                    "Restaurants",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: GestureDetector(
                  child: Icon(Icons.keyboard_arrow_right,
                      color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Column(children: <Widget>[
                ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    // Container(
                    //   height: 174.0,
                    //   width: 160.0,
                    //   padding: EdgeInsets.symmetric(vertical: 11.0),
                    //   color: Colors.red,
                    //   child: Image.asset(
                    //     "images/burger.jpg",
                    //     height: 140.0,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    Container(
                      width: 160.0,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 160.0,
                      color: Colors.green,
                    ),
                    Container(
                      width: 160.0,
                      color: Colors.yellow,
                    ),
                    Container(
                      width: 160.0,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ]))
        ],
      ),
    );

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topBannerSection,
          IconButton(
            splashColor: Colors.redAccent,
            onPressed: () => Navigator.of(context).pushNamed('/tutorial'),
            icon: Icon(Icons.home),
          ),
          restaurantsList,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
