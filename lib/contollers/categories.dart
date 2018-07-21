import 'dart:async';
import 'dart:convert';
import 'package:discoucher/models/datum.dart';
import 'package:http/http.dart' as http;

final String restaurantsEndpoint =
    "http://46.101.137.125/api/v1/establishments/restaurants";
final String hotelsEndpoint =
    "http://46.101.137.125/api/v1/establishments/hotels";
final String spasEndpoint = "http://46.101.137.125/api/v1/establishments/spas";

Future<List<Datum>> fetchCategory() async {
  final response = await http.get(Uri.encodeFull(restaurantsEndpoint),
      headers: {'Accept': 'application/json'});

  // Use the compute function to run parsePhotos in a separate isolate
  // return compute(parseData, response.body);
  return parseCategoriesData(response.body);
}

// A function that will convert a response body into a List<Photo>
List<Datum> parseCategoriesData(String responseBody) {
  final Map<String, dynamic> parsedJson = json.decode(responseBody);
  final List<dynamic> data = parsedJson['data'];

  return data.map<Datum>((item) => Datum.fromJson(item)).toList();
}
