import 'dart:async';

import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/models/attribute.dart';
import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/search/results-card.dart';
import 'package:discoucher/screens/search/suggestions-list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchDiscoucherSearchDelegate extends SearchDelegate<Datum> {
  final uuid = new Uuid();
  final searchController = new SearchController();

  final List<Datum> data = [
    new Datum(
      id: new Uuid().v1(),
      type: "Spa",
      attributes: new EstablishementAttributes(
          name: "Serena Spa", area: "Kimathi Street, CBD", location: "CBD"),
    ),
    new Datum(
      id: new Uuid().v1(),
      type: "Restaurant",
      attributes: new EstablishementAttributes(
          name: "Kilimanjaro", area: "Kimathi Street, CBD", location: "CBD"),
    ),
    new Datum(
      id: new Uuid().v1(),
      type: "Restaurant",
      attributes: new EstablishementAttributes(
          name: "Candles", area: "Juja", location: "CBD"),
    ),
    new Datum(
      id: new Uuid().v1(),
      type: "Restaurant",
      attributes: new EstablishementAttributes(
          name: "Candles", area: "Kimathi Street, CBD", location: "CBD"),
    ),
    new Datum(
      id: new Uuid().v1(),
      type: "Hotel",
      attributes: new EstablishementAttributes(
          name: "Kempinski", area: "Kimathi Street, CBD", location: "CBD"),
    ),
    new Datum(
      id: new Uuid().v1(),
      type: "Restaurant",
      attributes: new EstablishementAttributes(
          name: "Bao Box", area: "Kimathi Street, CBD", location: "CBD"),
    )
  ];

  final List<String> history = <String>[
    "Kilimanjaro",
    "About Thyme",
    "Serena",
    "pizza",
    "main",
  ];

  Future<List<Datum>> searchVoucher(String query) async {
    List<Datum> _searchResults = await searchController.searchVoucher(query);

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

  @override
  Widget buildResults(BuildContext context) {
    // TODO: Call Api here
    final List<Datum> searchResults =
        data.where((datum) => datum.attributes.name.contains(query)).toList();

    List<Datum> _searchResults;

    searchController.searchVoucher(query).then((onValue) {
      _searchResults = onValue;

      print("searchResults");
      print(_searchResults.toString());
    });

    if (searchResults == null && searchResults.length < 1) {
      return Center(
        child: Text('Nothing found :(', textAlign: TextAlign.center),
      );
    }

    List<Widget> resultsCards = [];
    searchResults.forEach((result) => resultsCards.add(
          ResultCard(
            datum: result,
            searchDelegate: this,
          ),
        ));

    return new ListView(children: resultsCards);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? history
        : data
            .where((Datum datum) => datum.attributes.name.contains(query))
            .map((datum) => datum.attributes.name);

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
