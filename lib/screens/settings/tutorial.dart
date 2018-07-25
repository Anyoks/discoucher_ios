import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => new _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  DiscoucherRoutes routes = new DiscoucherRoutes();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  toggleTopBarVisibility(bool isHidden) {
    isHidden
        ? SystemChrome.setEnabledSystemUIOverlays([])
        : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    Widget topBannerSection = new Center(
      child: new SizedBox(
        height: 73.0,
        width: 73.0,
        child: new Container(
          padding: EdgeInsets.all(5.0),
          color: Theme.of(context).primaryColor,
          child: new Image.asset("images/logo.png"),
        ),
      ),
    );

    // Widget uvpSection = Expanded(
    //   child: new CarouselSlider(
    //     height: 320.0,
    //     autoPlay: false,
    //     items: [1, 2, 3, 4, 5].map((i) {
    //       return new Builder(
    //         builder: (BuildContext context) {
    //           return new Container(
    //               width: MediaQuery.of(context).size.width,
    //               margin: new EdgeInsets.symmetric(horizontal: 5.0),
    //               decoration: new BoxDecoration(color: Colors.amber),
    //               child: new Text(
    //                 'text $i',
    //                 style: new TextStyle(fontSize: 16.0),
    //               ));
    //         },
    //       );
    //     }).toList(),
    //   ),
    // );

//    Widget uvpSection2 = new SizedBox(
//      height: 150.0,
//      width: 300.0,
//      child: new Carousel(
//        images: [
//          new NetworkImage(
//              'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
//          new NetworkImage(
//              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
//          new ExactAssetImage("images/uvp/save.png")
//        ],
//        carouselContent: [
//          new NetworkImage(
//              'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
//          new NetworkImage(
//              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
//          new ExactAssetImage("images/uvp/save.png")
//        ],
//        dotSize: 4.0,
//        dotSpacing: 15.0,
//        dotColor: Colors.lightGreenAccent,
//        indicatorBgPadding: 5.0,
//        dotBgColor: Colors.transparent,
//      ),
//    );

    Widget buildBottomText(String text) {
      return new Center(
        child: new Text(
          text,
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
        ),
      );
    }

    Widget bottomSection = new Container(
        color: Theme.of(context).primaryColor,
        child: new FlatButton(
          padding: const EdgeInsets.all(18.0),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBottomText("DISCOVER DEALS"),
              new Padding(padding: EdgeInsets.only(left: 18.0)),
              new Icon(Icons.keyboard_arrow_right, color: Colors.white),
              new Icon(Icons.keyboard_arrow_right, color: Colors.white)
            ],
          ),
        ));

    Widget loginOptionsSection = new Container(
      padding: const EdgeInsets.all(5.0),
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new SizedBox(
            width: 70.0,
            child: new FlatButton(
              padding: EdgeInsets.all(0.0),
              child: Text('Sign In'),
              onPressed: (() => routes.go(context, "LoginPage")),
            ),
          ),
          new Text(
            "|",
            style: new TextStyle(fontSize: 22.0),
          ),
          new Padding(padding: EdgeInsets.only(right: 15.0)),
          new Text("Continue With"),
          new FlatButton(
            onPressed: () => {},
            child: new Row(
              children: <Widget>[
                new Image.asset("images/social/fb.png", width: 20.0),
                new Padding(padding: EdgeInsets.only(left: 3.0)),
                new Text("Facebook")
              ],
            ),
          ),
          new FlatButton(
              onPressed: () => {},
              child: new Row(
                children: <Widget>[
                  new Image.asset(
                    "images/social/google.png",
                    width: 20.0,
                  ),
                  new Padding(padding: EdgeInsets.only(left: 3.0)),
                  new Text(
                    "Google",
                    style: new TextStyle(fontSize: 14.0),
                  )
                ],
              )),
        ],
      ),
    );

    Widget mainSection = new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          topBannerSection,
          new Padding(padding: EdgeInsets.only(top: 19.0)),
          // uvpSection,
          loginOptionsSection,
          bottomSection
        ],
      ),
    );

    return new Scaffold(body: mainSection);
  }
}
