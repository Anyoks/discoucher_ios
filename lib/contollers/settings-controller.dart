import 'package:url_launcher/url_launcher.dart';

class SettingsController {
  email(String email) async {
    final String url = 'mailto:$email';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  call(String phone) async {
    final String url = 'tel:$phone';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
