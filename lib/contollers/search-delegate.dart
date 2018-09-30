import 'dart:async';

import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/search/build-search-restults.dart';
import 'package:discoucher/screens/search/suggestions-list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchDiscoucherSearchDelegate extends SearchDelegate<VoucherData> {
  final uuid = new Uuid();
  final searchController = new SearchController();

  final List<String> history = <String>[
    "About Thyme",
    "Serena",
    "pizza",
    "main",
  ];

  Future<List<VoucherData>> searchVouchers(String query) async {
    List<VoucherData> _searchResults =
        await searchController.searchVoucher(query);
    return _searchResults;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? Container()
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
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

  Future<List<VoucherData>> fetchSearchResults() async {
    final results = await searchController.searchVoucher(query);
    return results;
  }

  @override
  Widget buildResults(BuildContext context) {
    return BuildSearchResults(
      vouchersFuture: fetchSearchResults(),
      searchDelegate: this,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty ? history : [];

    return SuggestionList(
      query: query,
      suggestions: suggestions.map((String name) => name).toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }
}
