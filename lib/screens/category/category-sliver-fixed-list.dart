import 'package:flutter/material.dart';

buildFixedList() {
  return SliverFixedExtentList(
    itemExtent: 50.0,
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          color: Colors.lightBlue[100 * (index % 9)],
          child: Text('list item $index'),
        );
      },
    ),
  );
}
