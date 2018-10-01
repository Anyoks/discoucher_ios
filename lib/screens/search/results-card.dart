import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/category/category-sliver-list.dart';
import 'package:discoucher/screens/details/voucher-details.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    this.voucherData,
    this.searchDelegate,
    this.closeSearchDelegate,
  });

  final VoucherData voucherData;
  final SearchDelegate<VoucherData> searchDelegate;
  final bool closeSearchDelegate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(closeSearchDelegate);
          if (closeSearchDelegate != null && closeSearchDelegate) {
            searchDelegate.close(context, voucherData);
          } else {
            Navigator.push(context, VoucherDetailsPageRoute(voucherData.attributes));
          }
        },
        child: buildCategoryListItem(context, voucherData.attributes));
  }
}
