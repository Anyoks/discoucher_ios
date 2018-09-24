import 'dart:async';

import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/contollers/tags-controller.dart';
import 'package:discoucher/models/tag-data.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/discover/discover-grid.dart';
import 'package:discoucher/screens/home/home-list-error.dart';
import 'package:discoucher/screens/shared/search-app-bar.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  TagsController _tagsController = new TagsController();
  SearchController _searchController = new SearchController();
  Future<List<TagData>> _tagsFuture;
  Future<List<VoucherData>> _searchResults;

  @override
  void initState() {
    _tagsFuture = _tagsController.loadTags();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: SearchAppBar(), body: buildDiscoveryFuture());
  }

  buildDiscoveryFuture() {
    return FutureBuilder(
      future: _tagsFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return HomeError(
                onPressed: () {
                  handleRefresh();
                },
                message: "You are offline");
          case ConnectionState.waiting:
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          default:
            if (snapshot.hasError)
              return HomeError(
                onPressed: () {
                  handleRefresh();
                },
                message:
                    "Search for a voucher, restarant, hotel, spa, location...",
              );
            else
              return (snapshot.data as List<TagData>).length > 0
                  ? buildDiscoverContent(snapshot.data)
                  : HomeError(
                      onPressed: () {
                        handleRefresh();
                      },
                      message:
                          "Search for a voucher, restarant, hotel, spa, location...",
                    );
        }
      },
    );
  }

  buildDiscoverContent(data) {
    return DiscoverGrid(data);
  }

  Future<List<TagData>> handleRefresh() async {
    Future<List<TagData>> tagsF = _tagsController.loadTags();

    setState(() {
      _tagsFuture = tagsF;
    });

    return tagsF;
  }

  void dispatchSearch() async {
   _searchResults = _searchController.searchVoucher("searchTerm");

    setState(() {
      // _tagsFuture = tagsF;
    });
  }
}
