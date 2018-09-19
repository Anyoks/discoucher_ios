import 'dart:async';
import 'dart:convert';
import 'package:discoucher/models/datum.dart';
import 'package:http/http.dart';

class HttpController {
  Client client;
  Map<String, String> _headers;

  HttpController() {
    client = new Client();

    // _headers = {
    //   'Content-Type': 'application/json',
    //   "access-token": "wyou8FqUHar0SAzB0eP2kQ",
    //   "client": "ZHZ4v8N1RgvuqVYLrovnkg",
    //   "uid": "testingbbc@api.com"
    // };
  }

  Future<Response> post(
      {String endPoint, Map<String, String> headers, payload}) async {
    return await client.post(endPoint, headers: headers, body: payload);
  }

  Future<List<Datum>> search(
      String endPoint, Map<String, String> payload) async {
    try {
      var res = await client.post(endPoint,
          headers: _headers, body: payload.toString());
      List<Datum> results = parseSectionData(res.body);
      print("searchResults");
      print(results);
      return results;
    } catch (e) {
      print("error: ");
      print(e.toString());
      return null;
    }
  }

  List<Datum> parseSectionData(String responseBody) {
    final Map<String, dynamic> parsedJson = json.decode(responseBody);
    final List<dynamic> data = parsedJson['data'];

    return data.map<Datum>((item) => Datum.fromJson(item)).toList();
  }
}
