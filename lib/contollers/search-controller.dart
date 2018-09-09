import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/models/voucher.dart';

class SearchController {
  HttpController httpController = new HttpController();

  Future<List<Voucher>> searchVoucher(String searchTerm) async {
    try {
      Map<String, String> payload = {"query": searchTerm};

      final response = httpController.post(Endpoints.searchEndpoint, payload);

      Map<String, dynamic> parsedJson;

      // response.then((onValue) {
      //   parsedJson = json.decode(onValue.body);
      // }).catchError((onError) {
      //   parsedJson = {"Errror": onError};
      // });

      // final results = await httpController.search(Endpoints.searchEndpoint, payload);
      // print("results: ");
      // print(results);

      final jsonStr =
          '{"data":[{"id":"d5dd2b80-04a1-4300-b112-82b8286352c4","type":"vouchers","attributes":{"code":"KWYEJ","description":"Get one Free Entree\nwhen an Entree\nis bought.","condition":"Get one Free Pizza\nwhen a Pizza\nis bought.","establishment":{"data":{"id":"93bb5882-1438-4d8b-8612-2ac83e88cf44","type":"establishment","attributes":{"name":"Muna Tree","area":"Nairobi","location":"Limuru","featured_image":"http://46.101.137.125/images/0c4497b4-9104-4a88-9826-4e8f157fdbc1/medium_Muna_Tree.jpg?1532455293"}}}}},{"id":"61c84ff7-3243-4b15-951f-7b72776f4dd1","type":"vouchers","attributes":{"code":"ZX201","description":"Get one Free Entree\nwhen an Entree\nis bought.","condition":"Get one Free Pizza\nwhen a Pizza\nis bought.","establishment":{"data":{"id":"93bb5882-1438-4d8b-8612-2ac83e88cf44","type":"establishment","attributes":{"name":"Muna Tree","area":"Nairobi","location":"Limuru","featured_image":"http://46.101.137.125/images/0c4497b4-9104-4a88-9826-4e8f157fdbc1/medium_Muna_Tree.jpg?1532455293"}}}}}],"jsonapi":{"version":"1.0"}}';
      parsedJson = json.decode(jsonStr.replaceAll("\n", ""));
      final List<dynamic> items = parsedJson['data'];

      var data = items
          .map<Voucher>(
              (item) => Voucher.fromJson(item["attributes"]))
          .toList();

      return data;
    } catch (e) {
      return null;
    }
  }
}
