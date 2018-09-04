import 'dart:async';
import 'package:discoucher/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/constants/enums.dart';
import 'package:discoucher/constants/strings.dart';

class SettingsController {
  final SharedPrefefencedController prefs;
  final GlobalKey<ScaffoldState> scaffoldKey;

  SettingsController({@required this.prefs, @required this.scaffoldKey});

  Future<void> email() async {
    final String url = 'mailto:$discoucherEmail';
    await launchUrl(url);
  }

  Future<void> call() async {
    final String url = 'tel:$discoucherPhone';
    await launchUrl(url);
  }

  lauchSocial(SocialSite site) async {
    String url = "";

    switch (site) {
      case SocialSite.Facebook:
        {
          url = discoucherFacebook;
          break;
        }
      case SocialSite.Twitter:
        {
          url = discoucherTwitter;
          break;
        }
      case SocialSite.Instagram:
        {
          url = discoucherInstagram;
          break;
        }
      case SocialSite.Website:
        {
          url = "http://$discoucherWebsite";
          break;
        }
    }

    await launchUrl(url);
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<LoggedInUser> checkLoggedIn() async {
    return await prefs.fetchLoggedInUser();
  }

  Future logOut() async {
    // TODO: Implement this
    await prefs.updateLoggedInUser(null).whenComplete(() => _logOut());
  }

  _logOut() {
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(content: new Text("You have been logged out")),
    );
    scaffoldKey.currentState.setState(() {});
  }

  openProfilePage(BuildContext context, LoggedInUser user) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ProfilePage(currentUser: user);
    }));
  }
}
