import 'dart:async';
import 'package:http/http.dart';

class HttpController {
  Client client;
  Map<String, String> _headers;

  HttpController() {
    client = new Client();

    _headers = {
      'Content-Type': 'application/json',
      "access-token": "wyou8FqUHar0SAzB0eP2kQ",
      "client": "ZHZ4v8N1RgvuqVYLrovnkg",
      "uid": "testingbbc@api.com"
    };
  }

  Future<Response> post(String endPoint, payload) async {
    return await client.post(endPoint, headers: _headers, body: payload);
  }
}
