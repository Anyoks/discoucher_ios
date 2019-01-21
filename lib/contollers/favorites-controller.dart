import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/models/voucher-data.dart';

class FavoritesController extends BaseController {
  Future<List<VoucherData>> getFavorites() async {
    try {
      final response = await fetch(endPoint: Endpoint.favorites);

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final List<dynamic> data = parsedJson['data'];

      List<VoucherData> _voucherDataList = data.map<VoucherData>((item) {
        VoucherData _voucherData = VoucherData.fromJson(item);
        if (_voucherData.attributes.description != null) {
          _voucherData.attributes.description =
              _voucherData.attributes.description.trim().replaceAll("\n", " ");
        }

        return _voucherData;
      }).toList();

      return _voucherDataList;
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

  Future<List<VoucherData>> getRedeemedOffers() async {
    try {
      final response = await fetch(endPoint: Endpoint.redeemedOffers);

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final List<dynamic> data = parsedJson['data'];

      List<VoucherData> _voucherDataList = data.map<VoucherData>((item) {
        VoucherData _voucherData = VoucherData.fromJson(item);
        if (_voucherData.attributes.description != null) {
          _voucherData.attributes.description =
              _voucherData.attributes.description.trim().replaceAll("\n", " ");
        }

        return _voucherData;
      }).toList();

      return _voucherDataList;
    } catch (e) {
      return null;
    }
  }

}
