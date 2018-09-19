import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:flutter/material.dart';

class AboutRoute extends MaterialPageRoute {
  AboutRoute() : super(builder: (context) => AboutPage());
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        title: AppBarTitle(appBarAbout),
      ),
      body: new Center(
        child: new Center(
          child: Text("About"),
        ),
      ),
    );
  }
}
