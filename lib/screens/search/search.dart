import 'package:flutter/material.dart';
import 'package:discoucher/contollers/search-controller.dart';

class SearchView extends StatefulWidget {
  // static const String routeName = '/material/search';

  @override
  _SearchViewState createState() => new _SearchViewState();
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
    return new Scaffold(
      //key: _scaffoldKey,
      appBar: new AppBar(
        leading: new IconButton(
          tooltip: 'Navigation menu',
          icon: new AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            color: Colors.white,
            progress: _searchDelegate.transitionAnimation,
          ),
          onPressed: () {
            // _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: const Text('Discover'),
        actions: <Widget>[
          new IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () {
              openSearch();
            },
          ),
          new IconButton(
            tooltip: 'More (not implemented)',
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new MergeSemantics(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
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
                  const Text(
                      'and search for an integer between 0 and 100,000.'),
                ],
              ),
            ),
            const SizedBox(height: 64.0),
            new Text(
                'Last selected integer: ${_lastIntegerSelected ?? 'NONE' }.')
          ],
        ),
      ),
      // floatingActionButton: new FloatingActionButton.extended(
      //   tooltip: 'Back', // Tests depend on this label to exit the demo.
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      //   label: const Text('Close demo'),
      //   icon: const Icon(Icons.close),
      // ),
    );
  }
}
