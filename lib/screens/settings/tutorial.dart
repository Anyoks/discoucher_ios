import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/screens/authentication/social-login-buttons.dart';
import 'package:discoucher/screens/home/entry.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  SharedPrefefencedController prefs = new SharedPrefefencedController();
  DiscoucherRoutes routes = DiscoucherRoutes();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  toggleTopBarVisibility(bool isHidden) {
    isHidden
        ? SystemChrome.setEnabledSystemUIOverlays([])
        : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTopBannerSection(context),
            Padding(padding: EdgeInsets.only(top: 19.0)),
            SizedBox(
              width: 70.0,
              child: FlatButton(
                padding: EdgeInsets.all(0.0),
                child: Text('Sign In'),
                onPressed: (() => routes.go(context, "LoginPage")),
              ),
            ),
            Text(
              "|",
              style: TextStyle(fontSize: 22.0),
            ),
            SizedBox(width: 15.0),
            buildCarousel(),
            SocialLoginButtons(routes, scaffoldKey, prefs),
            buildBottomSection(context)
          ],
        ),
      ),
    );
  }

  buildTopBannerSection(BuildContext context) => Center(
        child: SizedBox(
          height: 73.0,
          width: 73.0,
          child: Container(
            padding: EdgeInsets.all(5.0),
            color: Theme.of(context).primaryColor,
            child: Image.asset("images/logo.png"),
          ),
        ),
      );

  buildCarousel() {
    List<CarouselContent> carouselContents = [
      new CarouselContent("images/uvp/discover.png", "Discover"),
      new CarouselContent("images/uvp/buy2.jpg", "Buy"),
      new CarouselContent("images/uvp/save.png", "Save")
    ];

    return Expanded(
      child: CarouselSlider(
        height: 340.0,
        autoPlay: false,
        items: carouselContents.map((carouselContent) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(10.0)),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(carouselContent.imagePath),
                    ),
                  ),
                  child: Text(
                    carouselContent.text,
                    style: TextStyle(fontSize: 16.0),
                  ));
            },
          );
        }).toList(),
      ),
    );
  }

  buildBottomText(String text) => Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
        ),
      );

  buildBottomSection(BuildContext context) => Container(
        color: Theme.of(context).primaryColor,
        child: FlatButton(
          padding: const EdgeInsets.all(18.0),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return HomePage();
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBottomText("DISCOVER DEALS"),
              Padding(padding: EdgeInsets.only(left: 18.0)),
              Icon(Icons.keyboard_arrow_right, color: Colors.white),
              Icon(Icons.keyboard_arrow_right, color: Colors.white)
            ],
          ),
        ),
      );
}

class CarouselContent {
  final String imagePath;
  final String text;

  CarouselContent(this.imagePath, this.text);

  // CarouselContent.getContent()
}
