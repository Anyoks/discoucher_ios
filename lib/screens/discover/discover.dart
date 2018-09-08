import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/screens/shared/search-app-bar.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final _searchDelegate = SearchController.getDelegate();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(),
      body: Text('Color Palette'),
    );
  }
}
