import 'package:discoucher/screens/discover/discover.dart';
import 'package:discoucher/screens/home/body.dart';
import 'package:discoucher/screens/nearby/nearby.dart';
import 'package:discoucher/screens/settings/settings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final _SearchDelegate _delegate = new _SearchDelegate();

  int index = 0;

  SearchDelegate _homeSearchDelegate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container( 
        child: new Stack(
          children: <Widget>[
            buildOffStageItem(0, buildBody(context, _homeSearchDelegate)),
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

class _SearchDelegate extends SearchDelegate<int> {
  final List<int> _data =
      new List<int>.generate(100001, (int i) => i).reversed.toList();
  final List<int> _history = <int>[42607, 85604, 66374, 44, 174];

  @override
  Widget buildLeading(BuildContext context) {
    return new IconButton(
      tooltip: 'Back',
      icon: new AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<int> suggestions = query.isEmpty
        ? _history
        : _data.where((int i) => '$i'.startsWith(query));

    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    final int searched = int.tryParse(query);
    if (searched == null || !_data.contains(searched)) {
      return new Center(
        child: new Text(
          '"$query"\n is not a valid integer between 0 and 100,000.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return new ListView(
      children: <Widget>[
         Card(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Text("title"),
             
            ],
          ),
        ),
      ),
        
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? new IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : new IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

