import 'dart:async';
import 'dart:convert';
import 'package:discoucher/models/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefPaths {
  static final loggedInUser = "loggedInUser";
}

class SharedPrefefencedController {
  /// Update or delete a saved user
  Future<bool> updateLoggedInUser(LoggedInUser user) async {
    var results = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (user != null) {
        var localUser = json.encode(user);
        results = await prefs.setString(PrefPaths.loggedInUser, localUser);
      } else {
        results = await prefs.remove(PrefPaths.loggedInUser);
      }
    } catch (e) {
      results = false;
    }

    return results;
  }

  Future<LoggedInUser> fetchLoggedInUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String localUser = prefs.getString(PrefPaths.loggedInUser);
      final user = json.decode(localUser);

      return LoggedInUser.fromJsonMap(user);
    } catch (e) {
      return null;
    }
  }
}
