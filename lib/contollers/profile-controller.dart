import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:discoucher/models/user.dart';
import 'package:discoucher/constants/endpoints.dart';

class ProfileController {
  //TODO: Update url
  static const _serviceUrl = 'http://mockbin.org/echo';
  static final _headers = {'Content-Type': 'application/json'};

  var client = new Client();

  Future<User> updateUser(User _user) async {
    try {
      String payload = json.encode(_user);
      final response =
          await client.post(Endpoint.updateProfile, headers: _headers, body: payload);

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      var user = User.fromJson(parsedJson);
      return user;
    } catch (e) {
      return null;
    }
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  String fomatDate(DateTime date) {
    return new DateFormat.yMd().format(date);
  }

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  // TODO: Validate Kenyan phone number
  // validator: (value) => isValidPhoneNumber(value) ? null : 'Phone number must be entered as (###)###-####',
  bool isValidPhoneNumber(String input) {
    final RegExp regex = new RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return regex.hasMatch(input);
  }
}
