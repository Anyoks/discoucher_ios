import 'dart:async';

import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/home/home-list-error.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/screens/search/results-card.dart';

class BuildSearchResults extends StatelessWidget {
  final Future<List<VoucherData>> vouchersFuture;
  final SearchDelegate<VoucherData> searchDelegate;

  BuildSearchResults({
    @required this.vouchersFuture,
    @required this.searchDelegate,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> resultsCards = [];

    return FutureBuilder(
      future: vouchersFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("Nothing to show :(");
          case ConnectionState.waiting:
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          default:
            if (snapshot.hasError || snapshot.data.length < 1)
              return HomeError(
                hideRetry: true,
                message: "No results found :( ",
              );
            else {
              snapshot.data.forEach((result) => resultsCards.add(
                    ResultCard(
                      voucherData: result,
                      searchDelegate: searchDelegate,
                    ),
                  ));
              return new ListView(children: resultsCards);
            }
        }
      },
    );
  }
}
