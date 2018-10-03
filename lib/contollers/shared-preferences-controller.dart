import 'dart:async';
import 'dart:convert';
import 'package:discoucher/constants/pref-paths.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {
  SharedPreferences prefs;

  final List<String> initialHistory = [
    "Main course",
    "Free lunch",
    "massage",
    "date night",
    "cake"
  ];

  SharedPreferencesController() {
    initPref();
  }

  initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> updateLoggedInUser(LoggedInUser user) async {
    var results = false;

    try {
      if (user != null) {
        String localUser = json.encode(user);
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
      final String localUser = prefs.getString(PrefPaths.loggedInUser);
      final user = json.decode(localUser);
      LoggedInUser returnUser = LoggedInUser.fromJsonMap(user);

      return returnUser;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateHeaders(User user, Map<String, String> headers) async {
    var results = false;

    try {
      if (headers != null) {
        var _headers = json.encode(headers);
        results = await prefs.setString(PrefPaths.headers, _headers);
      } else {
        results = await prefs.remove(PrefPaths.headers);
      }
    } catch (e) {
      results = false;
    }

    return results;
  }

  Future<Map<String, String>> fetchHeaders() async {
    try {
      final String localHeaders = prefs.getString(PrefPaths.headers);
      final Map<String, String> _headers = json.decode(localHeaders);

      return _headers;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateInitialLaunch(bool isFirstTime) async {
    try {
      if (isFirstTime != null) {
        return await prefs.setBool(PrefPaths.isInitialLaunch, isFirstTime);
      } else {
        return await prefs.remove(PrefPaths.isInitialLaunch);
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> fetchInitialLaunch() async {
    try {
      return prefs.getBool(PrefPaths.isInitialLaunch);
    } catch (e) {
      return false;
    }
  }

  // TODO: Refine this

  updateSearchHistory(String searchTerm) async {
    if (searchTerm == null || searchTerm.length < 1) {
      return;
    }

    var prefs = await SharedPreferences.getInstance();
    try {
      List<String> history = await fetchSearchHistory();
      // print("before edit.....................");
      // print(history);
      if (history != null) {
        for (int i = 4; i >= 0; i--) {
          if (i == 0) {
            history[i] = searchTerm;
          } else {
            history[i] = history[i - 1];
          }
        }
        // print("after edit.....................");
        // print(history);
        prefs.setStringList(PrefPaths.searchHistory, history);
      } else {
        prefs.setStringList(PrefPaths.searchHistory, initialHistory);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>> fetchSearchHistory() async {
    List<String> ret = [];
    try {
      var prefs = await SharedPreferences.getInstance();

      var _searchHistory = prefs.getStringList(PrefPaths.searchHistory);

      if (_searchHistory == null) {
        prefs.setStringList(PrefPaths.searchHistory, initialHistory);
        ret = initialHistory;
      } else {
        ret = _searchHistory;
      }
    } catch (e) {
      prefs.setStringList(PrefPaths.searchHistory, initialHistory);
      ret = initialHistory;
    }

    return ret;
  }
}
