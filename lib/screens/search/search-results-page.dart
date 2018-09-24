import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/contollers/search-delegate.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/search/build-search-restults.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:flutter/material.dart';

class SearchResultsPageRoute extends MaterialPageRoute {
  SearchResultsPageRoute(String _searchTerm)
      : super(builder: (context) => SearchResultsPage(_searchTerm));
}

class SearchResultsPage extends StatelessWidget {
  final String searchTerm;

  final SearchDelegate<VoucherData> searchDelegate =
      new SearchDiscoucherSearchDelegate();
  final SearchController searchController = new SearchController();

  // SearchResultsPage({
  //   @required this.searchTerm,
  //   @required this.searchDelegate,
  //   @required this.searchController,
  // });

  SearchResultsPage(this.searchTerm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        title: AppBarTitle(searchTerm),
      ),
      body: BuildSearchResults(
        vouchersFuture: searchController.searchVoucher(searchTerm),
        searchDelegate: searchDelegate,
      ),
    );
  }
}
