import 'package:discoucher/screens/discover/discover.dart';
import 'package:discoucher/screens/home/body.dart';
import 'package:discoucher/screens/nearby/nearby.dart';
import 'package:discoucher/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    // TODO: check auth
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: new Stack(
          children: <Widget>[
            buildOffStageItem(0, HomeBody()),
            buildOffStageItem(1, ExplorePage()),
            buildOffStageItem(2, NearbyPage()),
            buildOffStageItem(3, SettingsPage()),
          ],
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: this.index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        fixedColor: Colors.yellow,
        items: <BottomNavigationBarItem>[
          buildBottomBarItem(Icons.home, "Home"),
          buildBottomBarItem(Icons.search, "Discover"),
          buildBottomBarItem(Icons.location_on, "Nearby"),
          buildBottomBarItem(Icons.person, "Me"),
        ],
      ),
    );
  }

  buildOffStageItem(int position, Widget child) {
    return new Offstage(
      offstage: this.index != position,
      child: new TickerMode(
        enabled: this.index == position,
        child: child,
      ),
    );
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
}
