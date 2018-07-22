import 'package:discoucher/screens/playground/fading.dart';
import 'package:discoucher/screens/playground/play.dart';
import 'package:discoucher/screens/playground/presto.dart';
import 'package:discoucher/screens/authentication/login.dart';
import 'package:flutter/material.dart';

openPage(BuildContext context, String pageName) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    switch (pageName) {
      case "PlayPage":
        {
          return PlayPage(title: "Play Page");
        }
      case "PrestoPage":
        {
          return PrestoPage();
        }
      case "FadingPage":
        {
          return FadingPage();
        }
      case "LoginPage":
        {
          return LoginPage();
        }
      default:
        {
          return null;
        }
    }
  }));
}

openNotifications(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return LoginPage();
  }));
}

buildAppBar() {
  return Row( 
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Image.asset("images/logo"),
      Icon(
        Icons.search,
        color: Colors.pinkAccent,
      ),
      TextField(
        autofocus: false,
        autocorrect: true,
        style: TextStyle(color: Colors.black12),
        decoration: InputDecoration(
            icon: Icon(Icons.search),
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            hintText: 'Search discounts',
            hintStyle: TextStyle(color: Colors.grey)),
      )
    ],
  );
}

buildAppBar2(BuildContext context) {
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
        onPressed: () => openPage(context, "FadingPage"),
        padding: EdgeInsets.all(2.0),
        icon: Icon(Icons.open_with),
      ),
      IconButton(
        onPressed: () => openNotifications(context),
        padding: EdgeInsets.all(2.0),
        icon: Icon(Icons.notifications),
      ),
    ],
  );
}
