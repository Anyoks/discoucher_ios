import 'dart:async';

import 'package:discoucher/models/voucher-data.dart';
import 'package:flutter/material.dart';
import 'package:discoucher/screens/search/results-card.dart';

class BuildSearchRestults extends StatelessWidget {
  final Future<dynamic> _future;
  final SearchDelegate<VoucherData> _searchDelegate;

  BuildSearchRestults(this._future, this._searchDelegate);

  @override
  Widget build(BuildContext context) {
    List<Widget> resultsCards = [];

    return FutureBuilder(
      future: _future,
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
              print(snapshot.data.length);

            snapshot.data.forEach((result) => resultsCards.add(
                  ResultCard(
                    voucherData: result,
                    searchDelegate: _searchDelegate,
                  ),
                ));
            return new ListView(children: resultsCards);
        }
      },
    );
  }
}
