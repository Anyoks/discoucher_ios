import 'package:flutter/material.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/constants/enums.dart';

Widget buildBottomSection(SettingsController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      buildSocialIcon(SocialSite.Facebook, controller),
      buildSocialIcon(SocialSite.Instagram, controller),
      buildSocialIcon(SocialSite.Twitter, controller),
    ],
  );
}

Widget buildSocialIcon(SocialSite site, SettingsController controller) {
  final String platform =
      SocialSite.values[site.index].toString().substring(11);
  final String imagePath = platform.toLowerCase();

  return new RawMaterialButton(
    onPressed: () {
      controller.lauchSocial(site);
    },
    shape: new CircleBorder(),
    elevation: 0.0,
    fillColor: Colors.white,
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: <Widget>[
        Image.asset("images/social/$imagePath.png", height: 40.0),
        SizedBox(height: 10.0),
        Text(platform, style: TextStyle(fontSize: 13.0))
      ],
    ),
  );
}
