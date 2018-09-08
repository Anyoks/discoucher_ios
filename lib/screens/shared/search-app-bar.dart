import 'dart:async';
import 'package:discoucher/contollers/search-delegate.dart';
import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/details/establishment.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  double get myAppBarHeight => 56.0;

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  // TODO: implement preferredSize for tablets
  @override
  Size get preferredSize => new Size.fromHeight(myAppBarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  final appBarForeground = const Color(0XFFBDBDBD);

  final _searchDelegate = SearchDiscoucherSearchDelegate();

  Future openSearch() async {
    final Datum selected = await showSearch<Datum>(
      context: context,
      delegate: _searchDelegate,
    );

    if (selected != null) {
      Navigator.push(context, EstablishmentPageRoute(selected));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: null,
      // automaticallyImplyLeading: false,
      centerTitle: true,
      titleSpacing: 0.0,
      title: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 15.0),
            IconButton(
              tooltip: 'Search',
              icon: new AnimatedIcon(
                icon: AnimatedIcons.search_ellipsis,
                color: appBarForeground,
                progress: _searchDelegate.transitionAnimation,
              ),
              onPressed: () {
                openSearch();
              },
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  openSearch();
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          "discover hotels, spas, cafes...",
                          style: TextStyle(
                              fontSize: 16.0, color: appBarForeground),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 5.0),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0)
          ],
        ),
      ),
    );
  }
}
