import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/category/category-sliver-list.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({this.voucherData, this.searchDelegate});

  final VoucherData voucherData;
  final SearchDelegate<VoucherData> searchDelegate;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        searchDelegate.close(context, voucherData);
      },
      child: new Card(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              // new Text(voucherData.attributes.code), 
              buildCategoryListItem(context, voucherData.attributes)
            ],
          ),
        ),
      ),
    );
  }
}
