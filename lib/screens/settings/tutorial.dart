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
            buildCarousel(),
            Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80.0,
                    child: FlatButton(
                      child: Text('Sign In'),
                      onPressed: (() => routes.go(context, "LoginPage")),
                    ),
                  ),
                  Text(
                    "|",
                    style: TextStyle(fontSize: 22.0),
                  ),
                  SocialLoginButtons(routes, scaffoldKey, prefs),
                ],
              ),
            ),
            SizedBox(height: 15.0),
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
      new CarouselContent(
          imagePath: "images/uvp/buy2.jpg",
          title: "Buy",
          description:
              "Buy your DisCoucher book for KES2,000 and access over 150 vouchers valued at over KES650,000"),
      new CarouselContent(
          imagePath: "images/uvp/discover.png",
          title: "Discover",
          description:
              "Visit the establishment of your choosing, and present the waitress with your physical voucher. Create memories and savor experiences!"),
      new CarouselContent(
          imagePath: "images/uvp/save.png",
          title: "Save",
          description:
              "The item indicated on the voucher is deducted from your bill.")
    ];

    return Expanded(
      child: CarouselSlider(
        //height: 350.0,
        aspectRatio: 1.0,
        autoPlay: false,
        items: carouselContents.map((carouselContent) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                children: <Widget>[
                  Container(
                    height: 300.0,
                    width: 300.0,
                    foregroundDecoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(carouselContent.imagePath),
                      ),
                    ),
                    child: null,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    carouselContent.title,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 20.0),
                  ),
                  SizedBox(height: 15.0),
                  Expanded(
                    child: Container(
                      width: 250.0,
                      child: Text(
                        carouselContent.description,
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }

  buildBottomText(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
      ),
    );
  }

  buildBottomSection(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: FlatButton(
        padding: const EdgeInsets.all(18.0),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushReplacement(context,
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
}

class CarouselContent {
  final String imagePath;
  final String title;
  final String description;

  CarouselContent({this.imagePath, this.title, this.description});

  // CarouselContent.getContent()
}
