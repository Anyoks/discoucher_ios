import 'package:flutter/material.dart';

class HomeError extends StatelessWidget {
  final Function onPressed;

  HomeError({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        onPressed();
      },
      child: new Column(
        children: <Widget>[
          Text("Pull to refresh", style: TextStyle(color: Colors.blueGrey)),
          Icon(Icons.arrow_upward),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  "Nothing to see :(",
                  style: TextStyle(color: Colors.black),
                ),
                FlatButton(
                    onPressed: () {
                      onPressed();
                    },
                    child: Text("Refresh"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
