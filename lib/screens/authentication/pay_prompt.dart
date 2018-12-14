import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:discoucher/screens/shared/wavy-header-image.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:discoucher/constants/colors.dart';

// this it the  payment prompt for an existing User

class PayPromptRoute extends MaterialPageRoute {
  PayPromptRoute() : super(builder: (context) => PayPrompt());
}

class PayPrompt extends StatefulWidget {
  @override
  _PayPromptState createState() => _PayPromptState();
}

class _PayPromptState extends State<PayPrompt> {
  final DiscoucherRoutes _routes = DiscoucherRoutes();

  @override
  void initState() {
    super.initState();
  }

  void _submit() {
    goHome();
  }

  void goHome() {
    Navigator.popAndPushNamed(context, _routes.homeRoute);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        WavyHeaderImage(
          child: Image.asset(
            "images/banner.jpg",
            fit: BoxFit.cover,
            height: 200.0,
          ),
        ),
        SizedBox(width: 15.0),
        SizedBox(
          width: 15.0,
          height: 10.0,
        ),
        Container(
            alignment: Alignment(0.0, 0.0),
            // margin: EdgeInsets.only(left: 30.0, right: 10.0),
            child: boldGreenTitleText("Get Discoucher Now!")),
        Container(
          margin:
              EdgeInsets.only(left: 35.0, top: 15.0, bottom: 15.0, right: 35.0),
          padding: const EdgeInsets.all(3.0),
          decoration:
              new BoxDecoration(border: new Border.all(color: Colors.grey)),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(3.0),
                              child: Text('KES',
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20))),
                          Container(
                              padding: EdgeInsets.all(0),
                              child: Text('3,000',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 55.0))),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                      alignment: Alignment(0.0, 0.0),
                    ),
                    //),
                  ]),
              Text('/year',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
              SizedBox(
                width: 15.0,
                height: 40.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    // Navigator.push(context, LogInPageRoute(fromSplashScreen: false));
                  },
                  padding:
                      EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                  //borderSide: BorderSide(color: xDiscoucherGreen),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  elevation: 1.0,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
