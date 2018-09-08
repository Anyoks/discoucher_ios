import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/models/datum.dart';
import 'package:http/http.dart';

class HomeController {
  final AsyncMemoizer<List<List<Datum>>> _memoizer = AsyncMemoizer();
  var client = new Client();

  Future<List<List<Datum>>> fetchHomeData() async {
    List<String> endpoints = [
      Endpoints.restaurantsEndpoint,
      Endpoints.hotelsEndpoint,
      Endpoints.spasEndpoint
    ];

    List<Response> responses = await Future.wait(endpoints.map((endpoint) =>
        client.get(Uri.encodeFull(endpoint),
            headers: {'Accept': 'application/json'})));

    List<List<Datum>> sectionsLists = responses.map((response) {
      return parseSectionData(response.body);
    }).toList();

    client.close();
    return sectionsLists;
  }

  // Future<List<List<Datum>>> fetchHomeData() async {
  //   List<String> endpoints = [
  //     Endpoints.restaurantsEndpoint,
  //     Endpoints.hotelsEndpoint,
  //     Endpoints.spasEndpoint
  //   ];

  //   return _memoizer.runOnce(() async {
  //     List<Response> responses = await Future.wait(endpoints.map((endpoint) =>
  //         client.get(Uri.encodeFull(endpoint),
  //             headers: {'Accept': 'application/json'})));

  //     List<List<Datum>> sectionsLists = responses.map((response) {
  //       return parseSectionData(response.body);
  //     }).toList();

  //     client.close();
  //     return sectionsLists;
  //   });
  // }

  List<Datum> parseSectionData(String responseBody) {
    final Map<String, dynamic> parsedJson = json.decode(responseBody);
    final List<dynamic> data = parsedJson['data'];

    return data.map<Datum>((item) => Datum.fromJson(item)).toList();
  }
}
