import 'package:discoucher/contollers/home-controller.dart';
import 'package:discoucher/screens/home/top-banner.dart';
import 'package:discoucher/screens/shared/home-list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

buildBody(BuildContext context) {
  return buildHomeSections(context);
}

sectionBuilder(BuildContext context, List sections) {
  return ListView(
    children: <Widget>[
      topBannerSection,
      SizedBox(height: 10.0),
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

buildHomeSections(BuildContext context) {
  // TODO: Handle loading screens
  return FutureBuilder(
    future: getHomeSections(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Text("Nothing to show :(");
        case ConnectionState.waiting:
          return Container(
              // color: Colors.amber,
              child: Center(
            child: CircularProgressIndicator(),
          ));
        default:
          if (snapshot.hasError)
            return new Text('An error happened: ${snapshot.error}');
          else
            return sectionBuilder(context, snapshot.data);
      }
    },
  );
}
