import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/models/voucher.dart';

class FavoritesController extends BaseController {
  Future<List<Voucher>> getFavorites() async {
    try {
      final response = await httpController.fetch(
        endPoint: Uri.encodeFull(Endpoint.favorites),
        headers: headers,
      );

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final List<dynamic> data = parsedJson['data'];

      var vouchers =
          data.map<Voucher>((item) => Voucher.fromJson(item)).toList();

      return vouchers;
    } catch (e) {
      return null;
    }
  }

  Future<Voucher> addFavorite() async {
    try {
      final response = await httpController.post(
        endPoint: Uri.encodeFull(Endpoint.addFavorite),
        headers: headers,
      );

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final data = parsedJson['data'];
      final vouchers = Voucher.fromJson(data);

      return vouchers;
    } catch (e) {
      return null;
    }
  }
}
