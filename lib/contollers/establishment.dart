import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/models/establishment-full.dart';

class EstablishmentController extends BaseController {
  HttpController httpController = new HttpController();

  Future<EstablishmentFull> getEstablishement(String id) async {
    try {
      Map<String, String> payload = {"establishment_id": id};

      final response =
          await post(endPoint: Endpoint.singleEstablishment, payload: payload);

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final Map<String, dynamic> data = parsedJson['data'];
      final Map<String, dynamic> establishment = data['attributes'];

      EstablishmentFull est = EstablishmentFull.fromJson(establishment);
      if (est.description != null) {
        est.description = est.description.trim().replaceAll("\n", " ");
      }
      if (est.address != null) {
        est.address = est.address.trim().replaceAll("\n", " ");
      }

      return est;
    } catch (e) {
      return null;
    }
  }
}
