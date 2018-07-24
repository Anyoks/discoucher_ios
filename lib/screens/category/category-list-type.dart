import 'package:flutter/material.dart';

buildListTypeSelector() {
  return  Container( 
    child: Row(
      children: <Widget>[
        IconButton(
          tooltip: 'Grid view',
          icon: Icon(Icons.grid_on, color: Colors.green[900]),
          onPressed: () {
            print("Grid view selected");
          },
        ),
        IconButton(
          tooltip: 'Grid view',
          icon: Icon(Icons.grid_on, color: Colors.green[900]),
          onPressed: () {
            print("Grid view selected");
          },
        ),
        Center(child: Text("")),
      ],
    ),
  );
}
