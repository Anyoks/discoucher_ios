import 'dart:async';

import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:http/http.dart';

class BaseController {
  HttpController _httpController = new HttpController();
  SharedPreferencesController prefs = new SharedPreferencesController();

  Future<Response> fetch({
    String endPoint,
    Map<String, String> headers,
  }) =>
      _httpController.fetch(
        endPoint: endPoint,
        headers: headers,
      );

  Future<Response> post({
    String endPoint,
    Map<String, String> headers,
    Map<String, dynamic> payload,
  }) =>
      _httpController.post(
        endPoint: endPoint,
        headers: headers,
        payload: payload,
      );

  Future<Response> patch({
    String endPoint,
    Map<String, String> headers,
    Map<String, dynamic> payload,
  }) =>
      _httpController.patch(
        endPoint: endPoint,
        headers: headers,
        payload: payload,
      );
}
