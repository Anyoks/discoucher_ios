import 'package:flutter/material.dart';

class EstablishmentDetailsPage extends MaterialPageRoute<Null> {
  final String title;
  final String heroTag;
  String imageUrl = "images/establishments/mayura.jpg";

  EstablishmentDetailsPage(this.title, this.imageUrl, this.heroTag)
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
            body: new Center(
              child: GestureDetector(
                child: Hero(
                  tag: heroTag,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fitWidth,
                    width: 300.0,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
}
