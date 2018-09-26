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

      final response = await httpController.post(
          endPoint: Uri.encodeFull(Endpoint.singleEstablishment),
          headers: headers,
          payload: payload);

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final Map<String, dynamic> data = parsedJson['data'];
      final Map<String, dynamic> establishment = data['attributes'];

      EstablishmentFull est = EstablishmentFull.fromJson(establishment);

      return est;
    } catch (e) {
      return null;
    }
  }
}
