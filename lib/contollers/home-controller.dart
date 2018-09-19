import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:http/http.dart';

class HomeController extends BaseController {
  final AsyncMemoizer<List<List<Voucher>>> _memoizer = AsyncMemoizer();
  var client = new Client();

  Future<List<List<Voucher>>> fetchHomeData() async {
    List<String> endpoints = [
      Endpoint.restaurantVouchers,
      Endpoint.restaurantVouchers,
      Endpoint.restaurantVouchers
    ];

    List<Response> responses = await Future.wait(
      endpoints.map((endpoint) => client.get(
            Uri.encodeFull(endpoint),
            headers: headers,
          )),
    );

    List<List<Voucher>> sectionsLists =
        responses.map((response) => parseSectionData(response.body)).toList();

    client.close();
    return sectionsLists;
  }

  // Future<List<List<Voucher>>> fetchHomeData() async {
  //   List<String> endpoints = [
  //     Endpoint.restaurantVouchers,
  //     Endpoint.allVouchers,
  //     Endpoint.allVouchers
  //   ];

  //   return _memoizer.runOnce(() async {
  //     List<Response> responses = await Future.wait(endpoints.map((endpoint) =>
  //         client.get(Uri.encodeFull(endpoint),
  //             headers: {'Accept': 'application/json'})));

  //     List<List<Voucher>> sectionsLists = responses.map((response) {
  //       return parseSectionData(response.body);
  //     }).toList();

  //     client.close();
  //     return sectionsLists;
  //   });
  // }

  List<Voucher> parseSectionData(String responseBody) {
    final Map<String, dynamic> parsedJson = json.decode(responseBody);
    final List<dynamic> data = parsedJson['data'];

    if (data != null) {
      var dataItems = data.map<Voucher>((item) {
        final Map<String, dynamic> attributes = item['attributes'];
        return Voucher.fromJson(attributes);
      }).toList();
      return dataItems;
    } else {
      return [];
    }
  }
}
