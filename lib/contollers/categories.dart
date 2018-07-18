import 'dart:async';
import 'dart:convert';
import 'package:discoucher/models/datum.dart';
import 'package:http/http.dart' as http;


 final String restaurantsEndpoint =
      "http://46.101.137.125/api/v1/establishments/restaurants";
  final String hotelsEndpoint =
      "http://46.101.137.125/api/v1/establishments/hotels";
  final String spasEndpoint =
      "http://46.101.137.125/api/v1/establishments/spas";



Future<List<Datum>> fetchData() async {
    final response = await http.get(restaurantsEndpoint);

    // Use the compute function to run parsePhotos in a separate isolate
   // return compute(parseData, response.body);
   return parseData(response.body);
  }

// A function that will convert a response body into a List<Photo>
  List<Datum> parseData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Datum>((json) => Datum.fromJson(json)).toList();
  }

  Future<List<Datum>> getCategoryList() async {
    var response = await http.get(Uri.encodeFull(restaurantsEndpoint),
        headers: {'Accept': 'application/json'});

    Map<String, dynamic> resMap = json.decode(response.body);

    // var data = new Datum.fromJson(resMap['data']);

    List<Datum> data = resMap['data'].map<Datum>((item) {
      print(item);
      return Datum.fromJson(item);
    });

    // for (int i = 0; i < data.length; i++) {
    //   Datum dt = data[i];
    //   // print(dt);
    // }
    //print(data);

    return data.toList();
  }
