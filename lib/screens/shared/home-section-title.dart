import 'package:discoucher/screens/category/category-main.dart';
import 'package:flutter/material.dart';

openCategoryPage(BuildContext context, String title) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return CategoryPage(category: 'Hotels');
  }));
}

buildHomeSectionTitle(BuildContext context, String title) {
  return Container(
    margin: EdgeInsets.only(left: 2.0, right: 3.0, bottom: 15.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment(-1.0, 0.0),
            child: GestureDetector(
              onTap: () {
                //TODO: Implement arrow click
                openCategoryPage(context, title);
              },
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            //TODO: Implement arrow click
            openCategoryPage(context, title);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: GestureDetector(
              child: Icon(Icons.keyboard_arrow_right,
                  size: 25.0, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    ),
  );
}
