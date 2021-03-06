import 'package:discoucher/contollers/search-controller.dart';
import 'package:discoucher/contollers/search-delegate.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/search/build-search-results.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:flutter/material.dart';

class SearchResultsPageRoute extends MaterialPageRoute {
  SearchResultsPageRoute({String searchTerm, bool closeSearchDelegate})
      : super(
          builder: (context) => SearchResultsPage(
                searchTerm: searchTerm,
                closeSearchDelegate: closeSearchDelegate,
              ),
        );
}

class SearchResultsPage extends StatelessWidget {
  final String searchTerm;
  final bool closeSearchDelegate;

  final SearchDelegate<VoucherData> searchDelegate =
      new SearchDiscoucherSearchDelegate();
  final SearchController searchController = new SearchController();

  // SearchResultsPage({
  //   @required this.searchTerm,
  //   @required this.searchDelegate,
  //   @required this.searchController,
  // });

  SearchResultsPage({this.searchTerm, this.closeSearchDelegate});

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
        closeSearchDelegate: closeSearchDelegate,
      ),
    );
  }
}
