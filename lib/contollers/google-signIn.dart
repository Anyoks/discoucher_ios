import 'dart:async';
import 'package:discoucher/models/shared.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController {
  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<LoginResults> signIn() async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      if (account != null) {
        return new LoginResults(
          success: true,
          profile: account,
          message: "Login successful",
        );
      } else {
        return new LoginResults(
          success: false,
          message: "Login was canceled",
        );
      }
    } catch (error) {
      return new LoginResults(
        success: false,
        message:
            "Unable to login at the moment, please check your network and try again",
      );
    }
  }
}
