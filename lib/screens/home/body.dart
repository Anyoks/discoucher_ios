import 'dart:async';

import 'package:discoucher/contollers/home-controller.dart';
import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/home/home-list-error.dart';
import 'package:discoucher/screens/home/horizontal-list.dart';
import 'package:discoucher/screens/home/top-banner.dart';
import 'package:discoucher/screens/shared/search-app-bar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => new _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _homeController = new HomeController();

  Future<List<List<Datum>>> _homeFuture;

  @override
  void initState() {
    _homeFuture = _homeController.fetchHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Handle loading screens

    return Scaffold(
      appBar: SearchAppBar(),
      body: FutureBuilder(
        future: _homeFuture,
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
                return HomeError(onPressed: () {
                  reloadFuture();
                });
              else
                return sectionBuilder(context, snapshot.data);
          }
        },
      ),
    );
  }

  reloadFuture() {
    _homeFuture = _homeController.fetchHomeData();
  }

  sectionBuilder(BuildContext context, List sections) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 5.0),
        topBannerSection,
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          key: new Key(new Uuid().v1()),
          scrollDirection: Axis.vertical,
          itemCount: sections.length,
          itemBuilder: (BuildContext context, int index) {
            return buildHomeList(context, sections[index]);
          },
        )
      ],
    );
  }
}
