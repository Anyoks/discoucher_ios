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

// buildAppBar(){
//   return HomeAppBar();
// }

buildAppBar(BuildContext context) {
  // final appBarBackground = const Color(0XFFE5E5E5);
  final appBarBackground = Colors.green[900];
  final appBarForeground = const Color(0XFFBDBDBD);

  return AppBar(
    // elevation: 1.0,
    backgroundColor: appBarBackground,
    centerTitle: true,
    titleSpacing: 0.0,
    title: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 5.0),
          Container(
            child: Image.asset(
              "images/simple-logo.png",
              fit: BoxFit.fitHeight,
              height: 25.0,
            ),
          ),
          SizedBox(width: 10.0),
          Flexible(
            child: GestureDetector(
              onTap: () async {
                 print("Searching....");
                // final int selected = await showSearch<int>(
                //   context: context,
                //   delegate: _delegate,
                // );
                // if (selected != null) {
                //   print(selected);
                // }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search, color: appBarForeground),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        "discover hotels, spas, cafes...",
                        style:
                            TextStyle(fontSize: 16.0, color: appBarForeground),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      IconButton(
        iconSize: 32.0,
        onPressed: () {
          print("pressed");
        },
        icon: Icon(Icons.notifications_none),
      ),
    ],
  );
}
