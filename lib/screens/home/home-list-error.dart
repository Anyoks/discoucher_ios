import 'package:discoucher/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeError extends StatelessWidget {
  final Function onPressed;
  final String message;

  HomeError({this.onPressed, this.message});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        onPressed();
      },
      child: buildHomeError(context),
    );
  }

  homeError() {
    return Column(
      children: <Widget>[
        Text("Pull to refresh", style: TextStyle(color: Colors.blueGrey)),
        Icon(Icons.arrow_upward),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                message,
                style: TextStyle(color: Colors.black),
              ),
              FlatButton(
                onPressed: () {
                  onPressed();
                },
                child: Text("Refresh"),
              )
            ],
          ),
        ),
      ],
    );
  }

  buildHomeError(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 100.0),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  "images/sad-face.png",
                  fit: BoxFit.cover,
                  height: 40.0,
                ),
                SizedBox(height: 30.0),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: FlatButton(
                    onPressed: () {
                      onPressed();
                    },
                    padding:
                        EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                    child: Text(
                      "Retry",
                      style: TextStyle(color: xDiscoucherGreen),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
