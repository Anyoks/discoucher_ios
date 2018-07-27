import 'package:flutter/material.dart';
import 'package:discoucher/contollers/search-controller.dart';

class SearchView extends StatefulWidget {
  // static const String routeName = '/material/search';

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
        title: const Text('Discover'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () {
              openSearch();
            },
          ),
          IconButton(
            tooltip: 'More (not implemented)',
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Tip', // Tests depend on this label to exit the demo.
        onPressed: () {
          // Navigator.of(context).pop();
        },
        label: const Text('Home '),
        icon: const Icon(Icons.close),
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
          Text('Last selected integer: ${_lastIntegerSelected ?? 'NONE' }.')
        ],
      ),
    );
  }
}
