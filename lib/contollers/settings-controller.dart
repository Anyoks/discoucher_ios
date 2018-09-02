import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';

class SettingsController {
  email(String email) async {
    final String url = 'mailto:$email';
    await launchUrl(url);
  }

  call(String phone) async {
    final String url = 'tel:$phone';
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
