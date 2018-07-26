import 'package:discoucher/contollers/home-controller.dart';
import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/screens/home/horizontal-list.dart';
import 'package:discoucher/screens/home/top-banner.dart';
import 'package:discoucher/screens/home/app-bar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => new _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  // final SearchHelper _searchHelper = new SearchHelper();
  final _searchDelegate = SearchHelper.getDelegate();

  int _lastIntegerSelected;

  openSearch() async {
    final int selected = await showSearch<int>(
      context: context,
      delegate: this._searchDelegate,
    );
    if (selected != null && selected != _lastIntegerSelected) {
      setState(() {
        _lastIntegerSelected = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Handle loading screens

    return Scaffold(
      appBar: buildHomeAppBar(),
      body: FutureBuilder(
        future: getHomeSections(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Nothing to show :(");
            case ConnectionState.waiting:
              return Container(
                  // color: Colors.amber,.
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            default:
              if (snapshot.hasError)
                return new Text('An error happened: ${snapshot}');
              else
                return sectionBuilder(context, snapshot.data);
          }
        },
      ),
    );
  }

  buildHomeAppBar() {
    // final appBarBackground = const Color(0XFFE5E5E5);
    final appBarBackground = Colors.green[900];
    final appBarForeground = const Color(0XFFBDBDBD);

    return AppBar(
      backgroundColor: appBarBackground,
      leading: null,
      automaticallyImplyLeading: false,
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
                onTap: () {
                  openSearch();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(5.0)),
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search, color: appBarForeground),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          "discover hotels, spas, cafes...",
                          style: TextStyle(
                              fontSize: 16.0, color: appBarForeground),
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
            print("show notifications");
          },
          icon: Icon(Icons.notifications_none),
        ),
      ],
    );
  }

  sectionBuilder(BuildContext context, List sections) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 5.0),
        topBannerSection,
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          key: new Key(new Uuid().v1()),
          scrollDirection: Axis.vertical,
          itemCount: sections.length,
          itemBuilder: (BuildContext context, int index) {
            return buildHomeList(context, sections[index]);
          },
        )
      ],
    );
  }
}
