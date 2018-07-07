import 'package:flutter/material.dart';
import '../redemptions.dart';
import '../addAccount.dart';
import '../profile.dart';
import '../settings.dart';
import '../help.dart';
import '../search.dart';
import '../../models/models.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String accountBackgroundUrl = "images/burger.jpg";
  var edwin =
  new Person("Edwin Maganjo", "edwin@discoucher.com", "images/edwin.jpg");
  var sharon = new Person(
      "Sharon Maganjo", "sharon@discoucher.com", "images/sharon.jpg");

  var currentUser = new Person(
      "Sharon Maganjo", "sharon@discoucher.com", "images/sharon.jpg");
  var otherUser =
  new Person("Edwin Maganjo", "edwin@discoucher.com", "images/edwin.jpg");

  void tapUser() {
    this.setState(() {
      if (currentUser == edwin) {
        currentUser = sharon;
        otherUser = edwin;
      } else {
        currentUser = edwin;
        otherUser = sharon;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 4,
      child: new Scaffold(
          appBar: new AppBar(
            title: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new Padding(
                  padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
                  child: new Image.asset('images/logo_with_no_name.png'),
                ),
                new Text("isCoucher")
              ],
            ),
            bottom: new TabBar(
              tabs: [
                new Tab(icon: new Icon(Icons.book), text: "All Vouchers"),
                new Tab(icon: new Icon(Icons.restaurant), text: "Restaurants"),
                new Tab(icon: new Icon(Icons.spa), text: "Beauty Spas"),
                new Tab(icon: new Icon(Icons.hotel), text: "Hotels")
              ],
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new SearchPage())),
                child: new Padding(
                  padding: new EdgeInsets.only(right: 8.0),
                  child: new Icon(Icons.search),
                ),
              ),
              //new Icon(Icons.filter_list),
            ],
          ),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  // onDetailsPressed: () {
                  //   Navigator.of(context).pop();
                  //   Navigator.of(context).push(new MaterialPageRoute(
                  //       builder: (BuildContext context) =>
                  //           new ProfilePage(currentUser)));
                  // },
                  accountName: new Text(currentUser.name),
                  accountEmail: new Text(currentUser.email),
                  currentAccountPicture: new GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new ProfilePage(currentUser)));
                    },
                    child: new CircleAvatar(
                      backgroundImage: new AssetImage(currentUser.profPic),
                      backgroundColor: Colors.red[300],
                      radius: 100.0,
                      //child: new Text("SM"),
                    ),
                  ),
                  otherAccountsPictures: <Widget>[
                    new GestureDetector(
                      onTap: () => tapUser(),
                      child: new CircleAvatar(
                        backgroundImage: new AssetImage(otherUser.profPic),
                        //backgroundColor: Colors.brown.shade800,
                        //child: new Text("EM"),
                      ),
                    )
                  ],
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: new AssetImage(accountBackgroundUrl))),
                ),
                new ListTile(
                    leading: new Icon(Icons.add),
                    title: new Text('Add account'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new AddAccountPage()));
                    }),
                new ListTile(
                  leading: new Icon(Icons.history),
                  title: new Text('My Redemptions'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new RedemptionsPage()));
                  },
                ),
                new Divider(),
                new ListTile(
                    leading: new Icon(Icons.settings),
                    title: new Text('Settings'),
                    onTap: () {
                      //Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new SettingsPage("Settings")));
                    }),
                new ListTile(
                    leading: new Icon(Icons.help),
                    title: new Text('Help & feedback'),
                    onTap: () {
                      //Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new HelpPage()));
                    })
              ],
            ),
          ),
          body: new TabBarView(
            children: [
              new Icon(Icons.book),
              new Icon(Icons.restaurant_menu),
              new Icon(Icons.spa),
              new Icon(Icons.hotel)
            ],
          )),
    );
  }
}
