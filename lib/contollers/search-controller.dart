import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/models/voucher-data.dart';

class SearchController extends BaseController {
  HttpController httpController = new HttpController();

  Future<List<VoucherData>> searchVoucher(String searchTerm) async {
    try {
      Map<String, String> payload = {"query": searchTerm.toLowerCase()};

      final response = await httpController.post(
        endPoint: Uri.encodeFull(Endpoint.search),
        headers: headers,
        payload: payload,
      );

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final List<dynamic> data = parsedJson['data'];

      var list =
          data.map<VoucherData>((item) => VoucherData.fromJson(item)).toList();

      return list;
    } catch (e) {
      return [];
    }
  }
}
