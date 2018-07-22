import 'package:discoucher/screens/home/app-bar.dart';
import 'package:discoucher/screens/home/body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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

  buildBottomBarItem(IconData icon, String title) {
    final rangi = const Color(0xFF4f4f4f);

    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: rangi,
      ),
      title: Text(
        title,
        style: TextStyle(color: rangi),
      ),
    );
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: index != 0,
            child: new TickerMode(
              enabled: index == 0,
              child: buildBody(context),
            ),
          ),
          new Offstage(
            offstage: index != 1,
            child: new TickerMode(
              enabled: index == 1,
              child: Text("Discover"),
            ),
          ),
          new Offstage(
            offstage: index != 2,
            child: new TickerMode(
              enabled: index == 2,
              child: Text("Nearby"),
            ),
          ),
          new Offstage(
            offstage: index != 3,
            child: new TickerMode(
              enabled: index == 3,
              child: Text("Me"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        fixedColor: Colors.yellow,
        items: <BottomNavigationBarItem>[
          buildBottomBarItem(Icons.home, "Home"),
          buildBottomBarItem(Icons.search, "Discover"),
          buildBottomBarItem(Icons.location_on, "Nerby"),
          buildBottomBarItem(Icons.person, "Me"),
        ],
      ),
    );
  }
}
