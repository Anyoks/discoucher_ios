import 'dart:async';
import 'package:discoucher/models/shared.dart';

class DiscoucherAuthController {
  Future<LoginResults> signIn() async {
    try {
      // var account = await _googleSignIn.signIn();
      // if (account != null) {
      //   return new LoginResults(
      //     success: true,
      //     profile: account,
      //     message: "Login successful",
      //   );
      // } else {
      //   return new LoginResults(
      //     success: false,
      //     message: "Login was canceled",
      //   );
      // }
    } catch (error) {
      return new LoginResults(
        success: false,
        message:
            "Unable to login at the moment, please check your network and try again",
      );
    }
    return null;
  }
}
