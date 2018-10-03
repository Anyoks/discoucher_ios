import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/models/voucher.dart';

class FavoritesController extends BaseController {
  Future<List<Voucher>> getFavorites() async {
    try {
      final response = await fetch(endPoint: Endpoint.favorites);

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final List<dynamic> data = parsedJson['data'];

      var vouchers =
          data.map<Voucher>((item) => Voucher.fromJson(item)).toList();

      return vouchers;
    } catch (e) {
      return null;
    }
  }

  Future<bool> addFavorite(VoucherData voucherData) async {
    try {
      final _payload = {"voucher_id": voucherData.id};

      final response = await post(
        endPoint: Endpoint.addFavorite,
        payload: _payload,
      );

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      // {
      //     "success": true,
      //     "message": "Voucher marked as favourite"
      // }

      final bool success = parsedJson['success'];

      return success;
    } catch (e) {
      return false;
    }
  }
}
