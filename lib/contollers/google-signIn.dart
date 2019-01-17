import 'dart:async';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth-controller.dart';

class GoogleSignInController {
  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final AuthController _controller = new AuthController();
  String email;

  User user = new User();

  Future<bool> signUpUser(GoogleSignInAccount account) async {
    user.email = account.email;
    user.firstName = account.displayName.split(' ')[0];
    user.lastName = account.displayName.split(' ')[1];
    user.password = user.firstName;
    user.passwordConfirmation = user.firstName;
    user.provider = "google";

    print(" SIgn up FIrst name " + account.displayName);

    SignUpResults signUpResults = await _controller.signUp(user);
    if (signUpResults != null && signUpResults.status) {
      // success
      print(" Inside  Sing up SUCCESS");
      return true;
    } else {
      // error
      print(" Inside  Sing up ERROR");
      return false;
    }
  }

  Future<User> loginUser(account) async {
    String password = account.displayName.split(' ')[0];
    var user = await _controller.login(email, password);

    if (user != null) {
      LoggedInUser _userToSave = new LoggedInUser(
        id: user.id,
        fullName: "${user.firstName} ${user.lastName}",
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        vouchers: user.vouchers,
      );
      print(" Inside  LOGIN SUCCESS" + user.email);
      return user;
    } else {
      //error
      print(" Inside  LOGIN ERROR");
      return null;
    }
  }

  Future<LoginResults> signIn() async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();

      if (account != null) {
        // check if user exists in db then sign them in with difault password
        // if not present, sign them up.
        email = account.email;

        String result = await _controller.checkUser(email);

        if (result == 'true') {
          // login user
          var login = await loginUser(account);

          if (login != null) {
            // success
            print(" Inside  GOOGLE SUCCESS" + login.email);
            return new LoginResults(
              success: true,
              profile: login,
              message: "Login successful",
            );
          } else {
            // failure
            return new LoginResults(
              success: false,
              profile: null,
              message: "Error Logging in",
            );
          }
        } else if (result == 'false') {
          // sign up user
          bool status = await signUpUser(account);

          if (status) {
            return new LoginResults(
              success: true,
              profile: null,
              message: "Login successful",
            );
          }
        } else {
          // error connecting.
          return new LoginResults(
            success: true,
            profile: null,
            message: " Error connecting to Server",
          );
        }
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
