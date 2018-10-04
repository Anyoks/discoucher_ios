import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';
import 'package:flutter/foundation.dart';

class SignUpResults {
  SignUpResults({@required this.status, @required this.message});
  final bool status;
  final String message;
}

class AuthController extends BaseController {
  Future<User> login(String email, String password) async {
    try {
      Map<String, String> payload = {
        "email": "$email",
        "password": "$password"
      };

      final response =
          await postAnonymous(endPoint: Endpoint.signIn, payload: payload);

      final Map<String, dynamic> parsedJson = json.decode(response.body);

      final Map<String, dynamic> data = parsedJson['data'];
      final Map<String, dynamic> userObj = data['user'];

      User user = User.fromJson(userObj);

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<SignUpResults> signUp(User _user) async {
    try {
      final newUser = {
        "email": "${_user.email}",
        "password": "${_user.password}",
        "password_confirmation": "${_user.passwordConfirmation}",
        "first_name": "${_user.firstName}",
        "last_name": "${_user.lastName}",
        "phone_number": "${_user.phoneNumber}"
      };

      final response = await postAnonymous(
        endPoint: Endpoint.signUp,
        payload: newUser,
      );

      final Map<String, dynamic> parsedJson = json.decode(response.body);

      final String status = parsedJson['status'];

      if (status == "success") {
        final Map<String, dynamic> data = parsedJson['data'];
        final Map<String, dynamic> userObj = data['user'];

        User user = User.fromJson(userObj);

        LoggedInUser loggedinUSer = LoggedInUser(
          id: user.id,
          fullName: "${user.firstName} ${user.lastName}",
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phoneNumber: user.phoneNumber,
        );

        saveLoggedInUser(loggedinUSer);

        return SignUpResults(
            status: true,
            message: "You have registered successfully to Discoucher");
      } else {
        final errors = parsedJson['errors'];
        final List<dynamic> errorMessages = errors['full_messages'];
        String _errorMessage = "";
        errorMessages.forEach((msg) {
          _errorMessage = "$_errorMessage \n $msg";
        });

        return SignUpResults(status: false, message: _errorMessage.trim());
      }
    } catch (e) {
      return SignUpResults(
        status: false,
        message:
            "There was an error signing up. Kindly check your details or try again later",
      );
    }
  }

  Future<bool> saveLoggedInUser(LoggedInUser user) async {
    return await prefs.updateLoggedInUser(user);
  }
}
