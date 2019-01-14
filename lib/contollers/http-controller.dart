import 'dart:async';
import 'dart:convert';

import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/header-params.dart';
import 'package:http/http.dart';

class HttpController {
  static SharedPreferencesController prefs = new SharedPreferencesController();
  HeaderParams incomingHeaders = new HeaderParams();

// headers change each time there's an http request. so update them often!
  _updateHeaders(headers) {
    final uid = headers["uid"];
    if (uid != null) {
      incomingHeaders.contentType = "application/json";
      incomingHeaders.client = headers["client"];
      incomingHeaders.accessToken = headers["access-token"];
      incomingHeaders.uid = headers["uid"];

      prefs.updateHeaders(incomingHeaders);
    }
  }

// make an http get request. Requires an endpoint and headers
  Future<Response> fetch({
    String endPoint,
    Map<String, String> headers,
  }) async {
    var _headers = await prefs.fetchHeaders();
    //  Future.delayed(const Duration(seconds: 2), () {
    //    var k;
    //  });

    print("THESE ARE THE HEADERS FROM HOME PAGE ****");
    print(_headers);

    Client client = new Client();
    final Response response = await client.get(endPoint, headers: _headers);
    client.close();
    print("THESE ARE THE HEADERS FROM HOME PAGE" + _headers.toString());
    if (response.headers['access-token'] != null && response.headers['access-token'] != ''  && response.headers['access-token'] != " ") {
      print("UPDATING HEADERS");
      print(response.headers);
      _updateHeaders(response.headers);
    }

    print("****");
    print(response.body);
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
       print("HEADERS BBBBBBB");
      var _headers = await prefs.fetchHeaders();

       print(_headers);

      Client client = new Client();

      final Response response = await client.post(
        Uri.encodeFull(endPoint),
        headers: _headers,
        body: json.encode(payload),
      );

      client.close();
      if (response.headers['access-token'] != null) {
        print("UPDATING POST HEADERS HEADERS BBBBBBB");
        _updateHeaders(response.headers);
      }
      // _updateHeaders(response.headers);

      return response;
    } catch (e) {
      return null;
    }
  }

//  Make http post without headers
  Future<Response> postAnonymous({String endPoint, dynamic payload}) async {
    try {
      const _anonymousHeaders = {"Content-Type": "application/json"};
      Client client = new Client();

      final Response response = await client.post(
        Uri.encodeFull(endPoint),
        headers: _anonymousHeaders,
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
