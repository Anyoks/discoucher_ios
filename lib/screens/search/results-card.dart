import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/category/category-sliver-list.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({this.voucher, this.searchDelegate});

  final Voucher voucher;
  final SearchDelegate<Voucher> searchDelegate;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        searchDelegate.close(context, voucher);
      },
      child: new Card(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Text(voucher.description),
              // buildCategoryListItem(context, voucher)
            ],
          ),
        ),
      ),
    );
  }
}
