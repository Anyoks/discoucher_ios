import 'dart:async';
import 'dart:convert';

import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/user.dart';
import 'package:http/http.dart';

class HttpController {
  static SharedPreferencesController prefs = new SharedPreferencesController();

  static const headers = {
    "Content-Type": "application/json",
    "access-token": "v-Grn-DL7hKFY14PH26pKw",
    "client": "nko10Oif0mo_XRhjNyW82A",
    "uid": "testing672@api.com"
  };

  // Future<Map<String, String>> get _headers async => await prefs.fetchHeaders();

  updateHeaders(User user, Map<String, String> headers) {
    prefs.updateHeaders(user, headers);
  }

  Future<Response> fetch({
    String endPoint,
    Map<String, String> headers = headers,
  }) async {
    Client client = new Client();
    final Response response = await client.get(endPoint, headers: headers);
    client.close();
    return response;
  }

  Future<Map<String, dynamic>> fetch2(String endPoint) async {
    try {
      Client client = new Client();
      final Response response = await client.get(endPoint, headers: headers);
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
    Map<String, String> headers = headers,
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
