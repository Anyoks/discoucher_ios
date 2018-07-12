import 'package:discoucher/screens/play.dart';
import 'package:discoucher/screens/presto.dart';
import 'package:discoucher/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/screens/home/generic-list.dart';
import 'package:discoucher/screens/home/top-banner.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
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

  homeAppBar(BuildContext context) {
    return AppBar(
      // backgroundColor: Color(0xFFE5E5E5),
      elevation: 0.1,
      // toolbarOpacity: 0.0,
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
        child: Image.asset('images/logo_with_no_name.png'),
      ),
      title: Container(
        width: 200.0,
        height: 30.0,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.pinkAccent,
            ),
            // TextField(
            //   autofocus: false,
            //   autocorrect: true,
            //   style: TextStyle(color: Colors.black12),
            //   decoration: InputDecoration(
            //       icon: Icon(Icons.search),
            //       prefixIcon: Icon(Icons.search),
            //       border: InputBorder.none,
            //       hintText: 'Search discounts',
            //       hintStyle: TextStyle(color: Colors.grey)),
            // )
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return PlayPage(title: "Play Page");
            }));
          },
          padding: EdgeInsets.all(2.0),
          icon: Icon(Icons.library_music),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return PrestoPage();
            }));
          },
          padding: EdgeInsets.all(2.0),
          icon: Icon(Icons.notifications),
        ),
      ],
    );
  }
}
