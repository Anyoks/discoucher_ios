import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => new _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  get back => null;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
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

    Widget buildDot = new Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Center(
        child: new Material(
          color: Colors.grey,
          type: MaterialType.circle,
          child: new Container(
            width: 6.0,
            height: 6.0,
            child: new InkWell(
              onTap: () => {},
            ),
          ),
        ),
      ),
    );

    buildUVPSingle(String uvpBanner, String title, String description) {
      return Column(
        children: <Widget>[
          new Container(
            width: 320.0,
            height: 320.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: new AssetImage(uvpBanner),
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 19.0)),
          new Text(
            title,
            style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          new Container(
            width: 360.0,
            child: new Padding(
              padding: EdgeInsets.all(19.0),
              child: new Text(
                description,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[buildDot, buildDot, buildDot],
          )
        ],
      );
    }

    // Widget uvpSection3 = Expanded(
    //   child: Carousel(
    //       children: [
    //     buildUVPSingle("images/uvp/buy.png", "BUY",
    //         "Buy your DisCoucher book for KES1,800 and access over 100 vouchers valued at over KES500,000"),
    //     buildUVPSingle("images/uvp/discover.png", "DISCOVER",
    //         "Visit the establishment of your choosing, and present the waitress with your physical voucher. Create memories and savor experiences!"),
    //     buildUVPSingle("images/uvp/buy2.jpg", "SAVE",
    //         "The item indicated on the voucher is deducted from your bill"),
    //   ].toList()),
    // );
    Widget uvpSection = Expanded(
      child: new CarouselSlider(
        height: 320.0,
        autoPlay: true,
        items: [1, 2, 3, 4, 5].map((i) {
          return new Builder(
            builder: (BuildContext context) {
              return new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: new EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: new BoxDecoration(color: Colors.amber),
                  child: new Text(
                    'text $i',
                    style: new TextStyle(fontSize: 16.0),
                  ));
            },
          );
        }).toList(),
      ),
    );

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
            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
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
              onPressed: (() {}),
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
          uvpSection,
          loginOptionsSection,
          bottomSection
        ],
      ),
    );

    return new Scaffold(body: mainSection);
  }
}
