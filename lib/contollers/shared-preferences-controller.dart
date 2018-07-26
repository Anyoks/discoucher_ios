import 'dart:async';
import 'dart:convert';
import 'package:discoucher/models/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class prefPaths {
  static final String loggedInUser = "loggedInUser";
}

class SharedPrefefencedController {
  Future<bool> updateLoggedInUser(LoggedInUser user) async {
    var results = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (user != null) {
        var localUserString = user.toJson();
        var localUser = json.encode(localUserString);
        results =
            await prefs.setString(prefPaths.loggedInUser.toString(), localUser);
        return results;
      } else {
        results = await prefs.remove(prefPaths.loggedInUser);
      }
    } catch (e) {
      print(e);
    }

    return results;
  }

  Future<LoggedInUser> fetchLoggedInUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String localUser = await prefs.getString(prefPaths.loggedInUser).toString();
      final user = json.decode(localUser);

      return LoggedInUser.fromJsonMap(user);
    } catch (e) {
      return null;
    }
  }
}
