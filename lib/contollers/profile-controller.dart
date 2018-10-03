import 'dart:async';
import 'dart:convert';

import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/models/user.dart';
import 'package:discoucher/constants/endpoints.dart';

class ProfileController extends BaseController {
  Future<User> updateUser(User _user) async {
    try {
      var payload = _user.toJson();
      
      payload.keys
          .where((k) => payload[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(payload.remove); // remove selected keys

      final response =
          await patch(endPoint: Endpoint.updateProfile, payload: payload);

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final Map<String, dynamic> data = parsedJson['data'];
      final Map<String, dynamic> userObj = data['user'];

      User user = User.fromJson(userObj);

      return user;
    } catch (e) {
      return null;
    }
  }
}
