import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';

class AuthController extends BaseController {
  final _anonymousHeaders = {"Content-Type": "application/json"};

  Future<User> login(String email, String password) async {
    try {
      Map<String, String> payload = {
        "email": "$email",
        "password": "$password"
      };

      final response = await post(
        endPoint: Endpoint.signIn,
        headers: _anonymousHeaders,
        payload: payload,
      );

      final Map<String, dynamic> parsedJson = json.decode(response.body);

      final Map<String, dynamic> data = parsedJson['data'];
      final Map<String, dynamic> userObj = data['user'];

      User user = User.fromJson(userObj);

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User> signUp(User _user) async {
    try {
      final newUser = {
        "email": "${_user.email}",
        "password": "${_user.password}",
        "password_confirmation": "${_user.passwordConfirmation}",
        "first_name": "${_user.firstName}",
        "last_name": "${_user.lastName}",
        "phone_number": "${_user.phoneNumber}"
      };
      final payload = json.encode(newUser);

      final response = await post(
        endPoint: Uri.encodeFull(Endpoint.signIn),
        headers: _anonymousHeaders,
        payload: payload,
      );

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final Map<String, dynamic> data = parsedJson['data'];
      final Map<String, dynamic> userObj = data['user'];

      User user = User.fromJson(userObj);

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveLoggedInUser(LoggedInUser user) async {
    return await prefs.updateLoggedInUser(user);
  }
}
