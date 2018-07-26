import 'package:discoucher/screens/authentication/social-login-buttons.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
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
            // uvpSection,
            SocialLoginButtons(routes, scaffoldKey),
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

  // Widget uvpSection = Expanded(
  //   child: CarouselSlider(
  //     height: 320.0,
  //     autoPlay: false,
  //     items: [1, 2, 3, 4, 5].map((i) {
  //       return Builder(
  //         builder: (BuildContext context) {
  //           return Container(
  //               width: MediaQuery.of(context).size.width,
  //               margin: EdgeInsets.symmetric(horizontal: 5.0),
  //               decoration: BoxDecoration(color: Colors.amber),
  //               child: Text(
  //                 'text $i',
  //                 style: TextStyle(fontSize: 16.0),
  //               ));
  //         },
  //       );
  //     }).toList(),
  //   ),
  // );

//    Widget uvpSection2 = SizedBox(
//      height: 150.0,
//      width: 300.0,
//      child: Carousel(
//        images: [
//          NetworkImage(
//              'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
//          NetworkImage(
//              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
//          ExactAssetImage("images/uvp/save.png")
//        ],
//        carouselContent: [
//          NetworkImage(
//              'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
//          NetworkImage(
//              'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
//          ExactAssetImage("images/uvp/save.png")
//        ],
//        dotSize: 4.0,
//        dotSpacing: 15.0,
//        dotColor: Colors.lightGreenAccent,
//        indicatorBgPadding: 5.0,
//        dotBgColor: Colors.transparent,
//      ),
//    );

  Widget buildBottomText(String text) => Center(
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
            Navigator.of(context).pop();
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
