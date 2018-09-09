import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/models/datum.dart';
import 'package:discoucher/models/discoucher.root.dart';

class SearchController {
  HttpController httpController = new HttpController();

  Future<List<Datum>> searchVoucher(String searchTerm) async {
    try {
      String payload = '{"query":"$searchTerm"}';

      final response = httpController.post(Endpoints.searchEndpoint, payload);

      Map<String, dynamic> parsedJson;
      response.then((onValue) {
        parsedJson = json.decode(onValue.body);
        print("searchResults");
        print(parsedJson);
      }).catchError((onError) {
        parsedJson = {"Errror": onError};
        print("error");
        print(onError);
      });

      var searchResults = DiscoucherRoot.fromJson(parsedJson);
      return searchResults.data;
    } catch (e) {
      return null;
    }
  }
}
