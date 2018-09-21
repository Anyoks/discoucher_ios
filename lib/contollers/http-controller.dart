import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class HttpController {
  Client client = new Client();

  Future<Response> fetch({String endPoint, Map<String, String> headers}) async {
    Client client = new Client();
    final response = await client.get(endPoint, headers: headers);
    client.close();
    return response;
  }

  Future<Response> post(
      {String endPoint, Map<String, String> headers, dynamic payload}) async {
    Client client = new Client();
    
    final response = await client.post(
      Uri.encodeFull(endPoint),
      headers: headers,
      body: json.encode(payload),
    );

    client.close();
    return response;
  }
}
