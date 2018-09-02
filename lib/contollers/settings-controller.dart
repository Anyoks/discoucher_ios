import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/constants/enums.dart';
import 'package:discoucher/constants/strings.dart';

class SettingsController {
  email() async {
    final String url = 'mailto:$discoucherEmail';
    await launchUrl(url);
  }

  call() async {
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
          url = discoucherWebsite;
          break;
        }
    }

    await launchUrl(url);
  }

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<LoggedInUser> checkLoggedIn() async {
    final SharedPrefefencedController prefs = SharedPrefefencedController();
    return await prefs.fetchLoggedInUser();
  }
}
