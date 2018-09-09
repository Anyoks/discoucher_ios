import 'dart:async';

import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/models/attribute.dart';
import 'package:discoucher/models/data-attributes.dart';
import 'package:discoucher/models/data.dart';
import 'package:discoucher/models/establishment.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/search/results-card.dart';
import 'package:discoucher/screens/search/suggestions-list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchDiscoucherSearchDelegate extends SearchDelegate<Voucher> {
  final uuid = new Uuid();
  final searchController = new SearchController();

  final List<Voucher> data = [
    new Voucher(
      code: new Uuid().v1(),
      condition: "Spa",
      establishment: new Establishment(
          data: new Data(attributes: new DataAttributes(name: "Kilimanjaro"))),
    ),
    new Voucher(
      code: new Uuid().v1(),
      condition: "Spa",
      establishment: new Establishment(
          data: new Data(attributes: new DataAttributes(name: "Serena Spa"))),
    ),
    new Voucher(
      code: new Uuid().v1(),
      condition: "Spa",
      establishment: new Establishment(
          data: new Data(attributes: new DataAttributes(name: "About Thyme"))),
    ),
    new Voucher(
      code: new Uuid().v1(),
      condition: "Spa",
      establishment: new Establishment(
          data: new Data(attributes: new DataAttributes(name: "Kempinski"))),
    ),
    new Voucher(
      code: new Uuid().v1(),
      condition: "Spa",
      establishment: new Establishment(
          data: new Data(attributes: new DataAttributes(name: "Pizza"))),
    ),
    new Voucher(
      code: new Uuid().v1(),
      condition: "Spa",
      establishment: new Establishment(
          data: new Data(attributes: new DataAttributes(name: "Pizza"))),
    )
  ];

  final List<String> history = <String>[
    "Kilimanjaro",
    "About Thyme",
    "Serena",
    "pizza",
    "main",
  ];

  Future<List<Voucher>> searchVoucher(String query) async {
    List<Voucher> _searchResults = await searchController.searchVoucher(query);
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
    final List<Voucher> searchResults = data
        .where(
            (datum) => datum.establishment.data.attributes.name.contains(query))
        .toList();

    List<Voucher> _searchResults;

    searchController.searchVoucher(query).then((onValue) {
      _searchResults = onValue;

      print("searchResults............");
      print(_searchResults.toString());
    });

    if (searchResults == null && searchResults.length < 1) {
      return Center(
        child: Text('Nothing found :(', textAlign: TextAlign.center),
      );
    }

    List<Widget> resultsCards = [];

    // searchResults.forEach((result) => resultsCards.add(
    //       ResultCard(
    //         datum: result,
    //         searchDelegate: this,
    //       ),
    //     ));

    // return new ListView(children: resultsCards);

    return FutureBuilder(
      future: searchController.searchVoucher(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("Nothing to show :(");
          case ConnectionState.waiting:
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          default:
            if (snapshot.hasError)
              return Text("Error: $snapshot");
            else
              snapshot.data.forEach((result) => resultsCards.add(
                    ResultCard(
                      voucher: result,
                      searchDelegate: this,
                    ),
                  ));
            return new ListView(children: resultsCards);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? history
        : data
            .where((Voucher voucher) =>
                voucher.establishment.data.attributes.name.contains(query))
            .map((voucher) => voucher.establishment.data.attributes.name);

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
