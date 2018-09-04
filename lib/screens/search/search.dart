import 'package:flutter/material.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/search-controller.dart';

class SearchView extends StatefulWidget {
  // static const String routeName = '/material/search';

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchDelegate = SearchHelper.getDelegate();

  int _lastIntegerSelected = 0;

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        // leading: IconButton(
        //   tooltip: 'Navigation menu',
        //   icon: AnimatedIcon(
        //     icon: AnimatedIcons.menu_arrow,
        //     color: Colors.white,
        //     progress: _searchDelegate.transitionAnimation,
        //   ),
        //   onPressed: () {
        //     // _scaffoldKey.currentState.openDrawer();
        //   },
        // ),
        title: Text(
          appBardiscover,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              openSearch();
            },
          ),
          IconButton(
            tooltip: 'More (not implemented)',
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Select search filters',
        onPressed: () {
          // Navigator.of(context).pop();
        },
        label: const Text('Filters'),
        icon: const Icon(Icons.settings),
      ),
    );
  }

  buildDummyDiscover() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MergeSemantics(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('Press the '),
                    Tooltip(
                      message: 'search',
                      child: Icon(
                        Icons.search,
                        size: 18.0,
                      ),
                    ),
                    Text(' icon in the AppBar'),
                  ],
                ),
                const Text('and search for an integer between 0 and 100,000.'),
              ],
            ),
          ),
          const SizedBox(height: 64.0),
          Text('Last selected integer: ${_lastIntegerSelected ?? 'NONE'}.')
        ],
      ),
    );
  }
}
