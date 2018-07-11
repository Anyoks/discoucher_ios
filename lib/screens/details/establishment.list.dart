import 'package:flutter/material.dart';

class EstablishmentListPage extends MaterialPageRoute<Null> {
  final String title;
  EstablishmentListPage(this.title)
      : super(builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text(title),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: new Center(child: new Text(title + " page")),
          );
        });
}
