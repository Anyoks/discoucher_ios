import 'dart:async';
import 'dart:convert';

import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/header-params.dart';
import 'package:http/http.dart';

class HttpController {
  static SharedPreferencesController prefs = new SharedPreferencesController();
  HeaderParams incomingHeaders = new HeaderParams();

  _updateHeaders(headers) {
    final uid = headers["uid"];
    if (uid != null) {
      incomingHeaders.accept = "application/json";
      incomingHeaders.client = headers["client"];
      incomingHeaders.accessToken = headers["access-token"];
      incomingHeaders.uid = headers["uid"];

      prefs.updateHeaders(incomingHeaders);
    }
  }

  Future<Response> fetch({
    String endPoint,
    Map<String, String> headers,
  }) async {
    var _headers = await prefs.fetchHeaders();

    Client client = new Client();
    final Response response = await client.get(endPoint, headers: _headers);
    client.close();

    return response;
  }

  Future<Map<String, dynamic>> fetch2(String endPoint) async {
    try {
      var _headers = await prefs.fetchHeaders();

      Client client = new Client();
      final Response response = await client.get(endPoint, headers: _headers);
      client.close();

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final Map<String, dynamic> data = parsedJson['data'];

      // _updateHeaders(response.headers);

      return data;
    } catch (e) {
      return null;
    }
  }

  Future<Response> post(
      {String endPoint, Map<String, String> headers, dynamic payload}) async {
    try {
      var _headers = await prefs.fetchHeaders();

      Client client = new Client();

      final Response response = await client.post(
        Uri.encodeFull(endPoint),
        headers: _headers,
        body: json.encode(payload),
      );

      client.close();

      _updateHeaders(response.headers);

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Response> postAnonymous({String endPoint, dynamic payload}) async {
    try {
      Client client = new Client();

      final Response response = await client.post(
        Uri.encodeFull(endPoint),
        headers: null,
        body: json.encode(payload),
      );

      client.close();

      _updateHeaders(response.headers);

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Response> patch(
      {String endPoint, Map<String, String> headers, dynamic payload}) async {
    var _headers = await prefs.fetchHeaders();

    Client client = new Client();

    final Response response = await client.patch(
      Uri.encodeFull(endPoint),
      headers: _headers,
      body: json.encode(payload),
    );

    client.close();

    _updateHeaders(response.headers);

    return response;
  }
}
