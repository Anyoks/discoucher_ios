import 'dart:async';
import 'dart:convert';
import 'package:discoucher/models/datum.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

final String restaurantsEndpoint =
    "http://46.101.137.125/api/v1/establishments/restaurants";
final String hotelsEndpoint =
    "http://46.101.137.125/api/v1/establishments/hotels";
final String spasEndpoint = "http://46.101.137.125/api/v1/establishments/spas";

Future<List<List<Datum>>> getHomeSections() async {
  var client = new Client();
  List<String> endpoints = [restaurantsEndpoint, hotelsEndpoint, spasEndpoint];

  List<Response> responses = await Future.wait(endpoints.map((endpoint) =>
      client.get(Uri.encodeFull(endpoint),
          headers: {'Accept': 'application/json'})));

  List<List<Datum>> sectionsLists = responses.map((response) {
    return parseSectionData(response.body);
  }).toList();

  client.close();
  return sectionsLists;
}

// A function that will convert a response body into a List<Photo>
List<Datum> parseSectionData(String responseBody) {
  final Map<String, dynamic> parsedJson = json.decode(responseBody);
  final List<dynamic> data = parsedJson['data'];

  return data.map<Datum>((item) => Datum.fromJson(item)).toList();
}
