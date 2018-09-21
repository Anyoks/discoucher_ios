import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/constants/enums.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/screens/settings/logged-in-settings.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:flutter/material.dart';

class AboutRoute extends MaterialPageRoute {
  AboutRoute({@required SettingsController ctrl})
      : super(builder: (context) => AboutPage(controller: ctrl));
}

class AboutPage extends StatelessWidget {
  final SettingsController controller;

  const AboutPage({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        title: AppBarTitle(appBarAbout),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Welcome to the new DisCoucher!",
                  style: TextStyle(
                      color: xDiscoucherIconGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                SizedBox(height: 25.0),
                Text.rich(
                  TextSpan(
                    text: 'DisCoucher is the leading provider of: ',
                    style: TextStyle(fontSize: 16.0),
                    children: <TextSpan>[
                      greenText("BUY ONE GET ONE FREE” DISCOUNTS "),
                      normalText(
                          "along with many other offers to Kenya’s best: Restaurants, cafes, bars, hotels, salons and spas. We have now taken these amazing deals and made them more accessible to you."),
                      normalText("\n"),
                      normalText("\n"),
                      normalText(
                          "For only KSH 2,000, you can get access to exclusive offers "),
                      greenText("worth over KSH 650,000 in savings"),
                      normalText(
                          ", giving you the best way to enjoy time with your family, friends, colleagues and loved ones, affordably."),
                      normalText("\n"),
                      normalText("\n"),
                      normalText(
                          "All the vouchers within our platform are valid from  2nd January to the 30th December ${new DateTime.now().year} excluding  public holidays."),
                    ],
                  ),
                ),
                SizedBox(height: 25.0),
                Text(
                  "Get in touch with us",
                  style: TextStyle(
                      color: xDiscoucherIconGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                SizedBox(height: 25.0),
                Text.rich(
                  TextSpan(
                    text:
                        "We always like to hear from people interested in DisCoucher. If you have any questions please drop us an email using the details below or give us a call.",
                    style: TextStyle(fontSize: 16.0),
                    children: <TextSpan>[
                      normalText("\n"),
                      normalText("\n"),
                      normalText(
                          "To speak to us about promoting your business on Discoucher, please include your company name and phone number when emailing and a member of our sales team will be happy to call you back to discuss."),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          buildSettingItem(
              tapEvent: () {
                controller.call(discoucherPhone1);
              },
              icon: Icons.phone,
              displayText: discoucherPhone1),
          buildSettingItem(
              tapEvent: () {
                controller.call(discoucherPhone2);
              },
              icon: Icons.phone,
              displayText: discoucherPhone2),
          buildSettingItem(
              tapEvent: () {
                controller.call(discoucherPhone3);
              },
              icon: Icons.phone,
              displayText: discoucherPhone3),
          buildSettingItem(
              tapEvent: () {
                controller.email();
              },
              icon: Icons.email,
              displayText: discoucherEmail),
          buildSettingItem(
              tapEvent: () {
                controller.lauchSocial(SocialSite.Website);
              },
              icon: Icons.link,
              displayText: discoucherWebsite),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
