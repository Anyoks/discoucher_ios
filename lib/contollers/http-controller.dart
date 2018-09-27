import 'dart:async';
import 'dart:convert';

import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:http/http.dart';

class HttpController {
  static SharedPreferencesController prefs = new SharedPreferencesController();

  // Future<Map<String, String>> get _headers async => await prefs.fetchHeaders();

  Future<Response> fetch({
    String endPoint,
    Map<String, String> headers,
  }) async {
    Client client = new Client();
    final Response response = await client.get(endPoint, headers: headers);
    client.close();
    return response;
  }

  Future<Response> post({
    String endPoint,
    Map<String, String> headers,
    dynamic payload,
  }) async {
    Client client = new Client();

    final Response response = await client.post(
      Uri.encodeFull(endPoint),
      headers: headers,
      body: json.encode(payload),
    );

    client.close();
    return response;
  }

  Future<Response> patch({
    String endPoint,
    Map<String, String> headers,
    dynamic payload,
  }) async {
    Client client = new Client();

    final Response response = await client.post(
      Uri.encodeFull(endPoint),
      headers: headers,
      body: json.encode(payload),
    );

    client.close();
    return response;
  }
}
