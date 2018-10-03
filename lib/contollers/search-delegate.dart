import 'dart:async';

import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/search/build-search-results.dart';
import 'package:discoucher/screens/search/suggestions-list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchDiscoucherSearchDelegate extends SearchDelegate<VoucherData> {
  final uuid = new Uuid();
  final searchController = new SearchController();
  SharedPreferencesController prefs = new SharedPreferencesController();
  List<String> history = [];

  SearchDiscoucherSearchDelegate() {
    initializeSearchHistory();
  }

  initializeSearchHistory() async {
    final _searchHistory = await prefs.fetchSearchHistory();

    if (_searchHistory != null) {
      _searchHistory.forEach((item) {
        if (item.length > 1) {
          history.add(item);
        }
      });
    }
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
    return await searchController.searchVoucher(query);
  }

  @override
  Widget buildResults(BuildContext context) {
    return BuildSearchResults(
      vouchersFuture: fetchSearchResults(),
      searchDelegate: this,
      closeSearchDelegate: true,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = query.isEmpty ? history : [];

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
