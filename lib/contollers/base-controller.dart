import 'dart:async';

import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/user.dart';
import 'package:http/http.dart';

class BaseController {
  HttpController httpController = new HttpController();
  SharedPreferencesController prefs = new SharedPreferencesController();

  final headers = {
    "Content-Type": "application/json",
    "access-token": "v-Grn-DL7hKFY14PH26pKw",
    "client": "nko10Oif0mo_XRhjNyW82A",
    "uid": "testing672@api.com"
  };

  final anonymousHeaders = {"Content-Type": "application/json"};

  Future<Response> fetch({
    String endPoint,
    Map<String, String> headers,
  }) =>
      httpController.fetch(
        endPoint: endPoint,
        headers: headers,
      );

  Future<Response> post({
    String endPoint,
    Map<String, String> headers,
    dynamic payload,
  }) =>
      httpController.post(
        endPoint: endPoint,
        headers: headers,
        payload: payload,
      );
}
