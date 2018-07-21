import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/shared/generic-list-item.dart';
import 'package:flutter/material.dart';

buildCategorySliverGrid(List<Datum> establishments) {
  return SliverGrid(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 160.0,
        crossAxisSpacing: 4.18,
        mainAxisSpacing: 4.18),
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        var data = establishments[index];
        return GestureDetector(
          onTap: () {
            print("pressed");
          },
          child: Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: buildGenericListItem(context, data)
              // new Text(establishments[index].id),

              // return new ListView.builder(
              //   itemCount: establishments.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return new Column(
              //       children: <Widget>[
              //         new ListTile(
              //           title: new Text(establishments[index].id),
              //         ),
              //         new Divider(
              //           height: 2.0,
              //         ),
              //       ],
              //     );
              //   },
              // );

              ),
        );
      },
      childCount: establishments.length,
    ),
  );
}

buildSliverGrid2() {
  return SliverPadding(
    padding: EdgeInsets.all(20.0),
    sliver: SliverGrid.count(
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      children: <Widget>[
        const Text('He\'d have you all unravel at the'),
        const Text('Heed not the rabble'),
        const Text('Sound of screams but the'),
        const Text('Who scream'),
        const Text('Revolution is coming...'),
        const Text('Revolution, they...'),
      ],
    ),
  );
}
