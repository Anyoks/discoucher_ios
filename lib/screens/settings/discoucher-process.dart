import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/constants/enums.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:flutter/material.dart';

class DiscoucherProcessRoute extends MaterialPageRoute {
  DiscoucherProcessRoute({LoggedInUser user, SettingsController ctrl})
      : super(
            builder: (context) => DiscoucherProcess(
                  currentUser: user,
                  controller: ctrl,
                ));
}

class DiscoucherProcess extends StatelessWidget {
  DiscoucherProcess(
      {Key key, @required this.currentUser, @required this.controller})
      : super(key: key);
  final LoggedInUser currentUser;
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    final firstName =
        currentUser != null ? currentUser.fullName.split(" ")[0] : "";

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        title: AppBarTitle(appBarDiscoucherProcess),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "We’re here to stretch the power of your shilling!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: xDiscoucherIconGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 25.0),
                Text.rich(
                  TextSpan(
                    text:
                        "DisCoucher offers you exclusive ‘Buy One Get One  Free’ discounts, along with other forms of discounts, to some of the best restaurants, hotels, beauty spas and more across Kenya. We want you ",
                    style: TextStyle(fontSize: 16.0),
                    children: <TextSpan>[
                      firstName != null && firstName.length > 0
                          ? TextSpan(
                              text: ", $firstName, ",
                              style: TextStyle(fontWeight: FontWeight.bold))
                          : normalText(""),
                      normalText(
                          "to comfortably venture out and try all the culinary, travel and beauty experiences that Kenya has to offer! Our offers, allow you to enjoy time out with your family and friends affordably."),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                boldGreenText("What’s Next?"),
                SizedBox(height: 20.0),
                Text(
                  "Redeem your voucher and save!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                buildRedeemingStep(
                  iconPath: "images/process/visit.png",
                  text:
                      "You and a friend go to the restaurant, salon, spa etc of your choice",
                ),
                buildSeparator(),
                buildRedeemingStep(
                  iconPath: "images/process/inform.png",
                  text: "Inform the service of your intent to use Discoucher",
                ),
                buildSeparator(),
                buildRedeemingStep(
                  iconPath: "images/process/redeem.png",
                  text:
                      "Click redeem button and show code to the service provider",
                ),
                buildSeparator(),
                buildRedeemingStep(
                  iconPath: "images/process/buy.png",
                  text: "Purchase your product",
                ),
                buildSeparator(),
                buildRedeemingStep(
                  iconPath: "images/process/discount.png",
                  text: "Redeem the offer on the voucher in return for Free!",
                ),
                SizedBox(height: 20.0),
                boldGreenText("The Discoucher Offer"),
                SizedBox(height: 25.0),
                Text.rich(
                  TextSpan(
                    text:
                        "Before proceeding to redeem the Discoucher offers, kindly ensure that you read each individual offer carefully. Note that the offers are valid solely for the items specified.",
                    style: TextStyle(fontSize: 16.0),
                    children: <TextSpan>[
                      normalText("\n"),
                      normalText("\n"),
                      normalText(
                          "Each offer can only be used once. DisCoucher offers cannot be redeemed for cash.")
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: OutlineButton(
              onPressed: () {
                // TODO: Change this to Discoucher process page
                controller.lauchSocial(SocialSite.Website);
              },
              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
              borderSide: BorderSide(color: xDiscoucherIconGreen),
              child: boldGreenText("View More Details"),
            ),
          ),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }

  buildRedeemingStep({String iconPath, String text}) {
    return Row(
      children: <Widget>[
        Image.asset(iconPath, height: 40.0, color: xDiscoucherIconGreen),
        SizedBox(width: 10.0),
        Expanded(child: Text(text))
      ],
    );
  }

  buildSeparator() {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      height: 35.0,
      decoration: new BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.green[100], width: 1.0),
        ),
      ),
    );
  }
}
