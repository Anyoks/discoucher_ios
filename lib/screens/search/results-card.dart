import 'package:discoucher/models/datum.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({this.datum, this.searchDelegate});

  final Datum datum;
  final SearchDelegate<Datum> searchDelegate;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        searchDelegate.close(context, datum);
      },
      child: new Card(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Text(datum.attributes.name),
            ],
          ),
        ),
      ),
    );
  }
}
