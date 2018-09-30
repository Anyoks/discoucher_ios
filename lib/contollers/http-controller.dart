import 'dart:async';
import 'dart:convert';

import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:http/http.dart';

class HttpController {
  static SharedPreferencesController prefs = new SharedPreferencesController();
  final _headers = {
    "Content-Type": "application/json",
    "access-token": "v-Grn-DL7hKFY14PH26pKw",
    "client": "nko10Oif0mo_XRhjNyW82A",
    "uid": "testing672@api.com"
  };

  final _anonymousHeaders = {
    "Content-Type": "application/json",
  };

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

  Future<Map<String, dynamic>> fetch2(String endPoint) async {
    try {
      Client client = new Client();
      final Response response = await client.get(endPoint, headers: _headers);
      client.close();

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final Map<String, dynamic> data = parsedJson['data'];

      return data;
    } catch (e) {
      return null;
    }
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
