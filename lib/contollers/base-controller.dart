import 'dart:async';

import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:http/http.dart';

class BaseController {
  HttpController _httpController = new HttpController();
  SharedPreferencesController prefs = new SharedPreferencesController();

  // make http get request
  Future<Response> fetch({
    String endPoint,
    Map<String, String> headers,
  }) =>
    _httpController.fetch(
      endPoint: endPoint,
      headers: headers,
    );

//  Make http post request
  Future<Response> post({
    String endPoint,
    Map<String, String> headers,
    dynamic payload,
  }) =>
    _httpController.post(
      endPoint: endPoint,
      headers: headers,
      payload: payload,
    );

//  Make http post without headers
  Future<Response> postAnonymous({
    String endPoint,
    dynamic payload,
  }) =>
    _httpController.postAnonymous(
      endPoint: endPoint,
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
