import 'package:discoucher/contollers/home-controller.dart';
import 'package:discoucher/screens/home/horizontal-list.dart';
import 'package:discoucher/screens/home/top-banner.dart';
import 'package:discoucher/screens/home/app-bar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

buildBody(BuildContext context, SearchDelegate _searchDelegate) {
  // TODO: Handle loading screens
  return Scaffold(
    appBar: buildAppBar(context, _searchDelegate),
    body: FutureBuilder(
      future: getHomeSections(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("Nothing to show :(");
          case ConnectionState.waiting:
            return Container(
                // color: Colors.amber,.
                child: Center(
              child: CircularProgressIndicator(),
            ));
          default:
            if (snapshot.hasError)
              return new Text('An error happened: ${snapshot}');
            else
              return sectionBuilder(context, snapshot.data);
        }
      },
    ),
  );
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
