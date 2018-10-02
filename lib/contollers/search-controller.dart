import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/voucher-data.dart';

class SearchController extends BaseController {
  HttpController httpController = new HttpController();
  SharedPreferencesController prefs = new SharedPreferencesController();

  Future<List<VoucherData>> searchVoucher(String searchTerm) async {
    try {
      Map<String, String> payload = {"query": searchTerm.toLowerCase()};

      final response = await httpController.post(
        endPoint: Endpoint.search,
        headers: headers,
        payload: payload,
      );

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final List<dynamic> data = parsedJson['data'];

      var list = data.map<VoucherData>((item) {
        VoucherData _voucherData = VoucherData.fromJson(item);
        _voucherData.attributes.description =
            _voucherData.attributes.description.trim().replaceAll("\n", " ");

        return _voucherData;
      }).toList();

      prefs.updateSearchHistory(searchTerm);

      return list;
    } catch (e) {
      return [];
    }
  }

  Future<List<VoucherData>> searchVouchersLive(String _searchTerm) async {
    try {
      //     new Observable(new Stream.fromIterable([1]))
      // .interval(new Duration(seconds: 1))
      // .flatMap((i) => new Observable.just(2))
      // .take(1)
      // .listen(print);

      //     new Observable.range(1, 100)
      // .debounce(new Duration(seconds: 1))
      // .listen(print);

      var _voucherData = await searchVoucher(_searchTerm);

      return _voucherData;
    } catch (e) {
      return [];
    }
  }
}
