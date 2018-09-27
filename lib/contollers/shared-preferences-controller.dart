import 'dart:async';
import 'dart:convert';
import 'package:discoucher/constants/pref-paths.dart';
import 'package:discoucher/models/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {
  SharedPreferences prefs;

  SharedPreferencesController() {
    initPref();
  }

  initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String> _getString(String path) async {
    final String ref = prefs.getString(path);

    return ref;
  }

  Future<bool> _setString(String path, String object) async {
    final bool ref = await prefs.setString(path, object);

    return ref;
  }

  Future<bool> _removeString(String path) async {
    final bool ref = await prefs.remove(path);
    return ref;
  }

  Future<bool> updateLoggedInUser(LoggedInUser user) async {
    var results = false;

    try {
      if (user != null) {
        var localUser = json.encode(user);
        results = await _setString(PrefPaths.loggedInUser, localUser);
      } else {
        results = await _removeString(PrefPaths.loggedInUser);
      }
    } catch (e) {
      results = false;
    }

    return results;
  }

  Future<LoggedInUser> fetchLoggedInUser() async {
    try {
      final String localUser = await _getString(PrefPaths.loggedInUser);
      final user = json.decode(localUser);

      return LoggedInUser.fromJsonMap(user);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateHeaders(Map<String, String> headers) async {
    var results = false;

    try {
      if (headers != null) {
        var _headers = json.encode(headers);
        results = await _setString(PrefPaths.headers, _headers);
      } else {
        results = await _removeString(PrefPaths.headers);
      }
    } catch (e) {
      results = false;
    }

    return results;
  }

  Future<Map<String, String>> fetchHeaders() async {
    try {
      final String localHeaders = await _getString(PrefPaths.headers);
      final Map<String, String> _headers = json.decode(localHeaders);

      return _headers;
    } catch (e) {
      return null;
    }
  }
}
