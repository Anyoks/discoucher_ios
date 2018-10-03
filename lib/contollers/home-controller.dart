import 'dart:async';
import 'dart:convert';
import 'package:discoucher/models/voucher-data.dart';
import 'package:http/http.dart';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';

class HomeController extends BaseController {
  Future<List<List<VoucherData>>> fetchHomeData() async {
    List<String> _endpoints = [
      Endpoint.restaurantVouchers,
      Endpoint.hotelVouchers,
      Endpoint.spaVouchers
    ];

    List<Response> responses = await Future.wait(
      _endpoints.map((endpoint) => fetch(endPoint: endpoint)),
    );

    var sectionsLists =
        responses.map((response) => parseSectionData(response.body)).toList();

    return sectionsLists;
  }

  List<VoucherData> parseSectionData(String responseBody) {
    Map<String, dynamic> parsedJson = json.decode(responseBody);
    var data = parsedJson['data'];

    try {
      var list = data.map<VoucherData>((item) {
        VoucherData _voucherData = VoucherData.fromJson(item);
        if (_voucherData.attributes.description != null) {
          _voucherData.attributes.description =
              _voucherData.attributes.description.trim().replaceAll("\n", " ");
        }
        return _voucherData;
      }).toList();

      return list;
    } catch (e) {
      return [];
    }
  }
}
