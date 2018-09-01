import 'package:url_launcher/url_launcher.dart';

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
}
