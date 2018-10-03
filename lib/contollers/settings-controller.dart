import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/constants/enums.dart';
import 'package:discoucher/constants/strings.dart';

class SettingsController {
  final SharedPreferencesController prefs;

  SettingsController({@required this.prefs});

  Future<void> email(String email) async {
    if (email != null) {
      final String url = 'mailto:$email';
      await launchUrl(url);
    }
  }

  Future<void> call(String phone) async {
    if (phone != null) {
      final String url = 'tel:$phone';
      await launchUrl(url);
    }
  }

  Future<void> browse(String website) async {
    if (website != null) {
      print("website");

      final String url =
          website.contains("http://") ? "$website" : "http://$website";
      print(url);
      await launchUrl(url);
    }
  }

  lauchSocial(SocialSite site) async {
    if (site != null) {
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
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url.trim())) {
      await launch(url);
    }
  }

  Future<LoggedInUser> checkLoggedIn() async {
    return await prefs.fetchLoggedInUser();
  }

  Future<bool> logOut() async {
    return await prefs.updateLoggedInUser(null);
  }
}
