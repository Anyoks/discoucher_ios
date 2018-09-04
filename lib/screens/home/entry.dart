import 'dart:async';
import 'dart:io';

import 'package:discoucher/screens/discover/discover.dart';
import 'package:discoucher/screens/home/body.dart';
import 'package:discoucher/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:discoucher/constants/strings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final HomeBody homePage = new HomeBody();
  final DiscoverPage discoverPage = new DiscoverPage();
  final SettingsPage settingsPage = new SettingsPage();

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

  Future<bool> _onWillPop() {
    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text('Are you sure you want to exit?'),
                content: new Text('Press yes again to exit'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      // TODO: Change this for iOs
                      // Navigator.of(context).pop(true);
                      exit(0);
                    },
                    child: new Text('Yes'),
                  ),
                ],
              );
            }) ??
        false;
  }

// TODO: Use SafeArea
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          child: new Stack(
            children: <Widget>[
              buildOffStageItem(0, homePage),
              buildOffStageItem(1, discoverPage),
              buildOffStageItem(2, settingsPage),
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
          type: BottomNavigationBarType.shifting,
          fixedColor: Colors.yellow,
          items: <BottomNavigationBarItem>[
            buildBottomBarItem(Icons.home, bottomBarHome),
            buildBottomBarItem(Icons.search, bottomBarDiscover),
            buildBottomBarItem(Icons.person, bottomBarme),
          ],
        ),
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
