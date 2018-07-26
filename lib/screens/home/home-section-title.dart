import 'package:discoucher/models/datum.dart';
import 'package:discoucher/screens/category/category-main.dart';
import 'package:flutter/material.dart';

openCategoryPage(BuildContext context, List<Datum> categoryData, String type) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return CategoryPage(
      category: categoryData,
      type: type,
    );
  }));
}

buildHomeSectionTitle(
    BuildContext context, List<Datum> categoryData, String type) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment(-1.0, 0.0),
            child: GestureDetector(
              onTap: () {
                //TODO: Implement arrow click
                openCategoryPage(context, categoryData, type);
              },
              child: Text(
                type,
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
            openCategoryPage(context, categoryData, type);
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