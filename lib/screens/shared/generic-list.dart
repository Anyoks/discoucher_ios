import 'package:discoucher/screens/details/establishment.dart';
import 'package:discoucher/screens/details/category.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


String getRandomString() => new Uuid().v1();

openEstablishmentDetails(
    BuildContext context, String title, String imageUrl, String heroTag) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return EstablishmentPage(
        title: title, imageUrl: imageUrl, heroTag: heroTag);
  }));
}

openCategoryPage(BuildContext context, String title) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return CategoryPage(category:'Hotels');
  }));
}

buildSectionTitle(BuildContext context, String title) {
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

buildListItemCategory(BuildContext context, String title, String imageUrl) {
  final String heroTag = getRandomString();
  // print(heroTag);

  return Container(
    // color: Colors.redAccent,
    width: 160.0,
    margin: EdgeInsets.only(right: 12.0),
    child: new GestureDetector(
      onTap: () {
        openEstablishmentDetails(context, title, imageUrl, heroTag);
      },
      child: Hero(
        tag: heroTag,
        child: Column(
          children: <Widget>[
            Container(
              height: 120.0,
              alignment: Alignment(0.0, 1.0),
              margin: EdgeInsets.only(bottom: 4.0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage(imageUrl),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Text(
                  "Ibis Styles",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              child: Text(
                "FREE LUNCH MAIN COURSE  dwwwdwwdwd wdwdwdwd wwdw when a Lunch Main Course ...",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: 11.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

buildListItem(BuildContext context, String title, String imageUrl) {
  final String heroTag = getRandomString();
  // print(heroTag);

  return Container(
    // color: Colors.redAccent,
    width: 160.0,
    margin: EdgeInsets.only(right: 12.0),
    child: new GestureDetector(
      onTap: () {
        openEstablishmentDetails(context, title, imageUrl, heroTag);
      },
      child: Hero(
        tag: heroTag,
        child: Column(
          children: <Widget>[
            Container(
              height: 120.0,
              alignment: Alignment(0.0, 1.0),
              margin: EdgeInsets.only(bottom: 4.0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage(imageUrl),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Text(
                  "Ibis Styles",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              child: Text(
                "FREE LUNCH MAIN COURSE  dwwwdwwdwd wdwdwdwd wwdw when a Lunch Main Course ...",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: 11.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

buildList(BuildContext context, String establishmentType) {
  return new Container(
    margin: EdgeInsets.only(left: 12.0, top: 12.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildSectionTitle(context, establishmentType),
        Container(
          height: 154.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              buildListItem(context, establishmentType, "images/burger.jpg"),
              buildListItem(context, establishmentType,
                  "images/establishments/mayura.jpg"),
              buildListItem(context, establishmentType,
                  "images/establishments/mister.jpg"),
              buildListItem(
                  context, establishmentType, "images/establishments/ob.jpg"),
              buildListItem(context, establishmentType,
                  "images/establishments/platter.png"),
            ],
          ),
        ),
      ],
    ),
  );
}

buildRestaurantsSection(BuildContext context) {
  return buildList(context, "Restaurants");
}

buildHotelsSection(BuildContext context) {
  return buildList(context, "Hotels");
}

buildSpasAndSalonsSection(BuildContext context) {
  return buildList(context, "Spas and Salons");
}

buildOutCountrySection(BuildContext context) {
  return buildList(context, "Up Country");
}
