import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/models/tag-data.dart';

class TagsController extends BaseController {
  HttpController httpController = new HttpController();

  Future<List<TagData>> loadTags() async {
    try {
      final response = await httpController.fetch(
        endPoint: Endpoint.tags.trim(),
        headers: headers,
      );

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final List<dynamic> data = parsedJson['data'];

      var tags =  data.map<TagData>((item) => TagData.fromJson(item)).toList();

      return tags;
    } catch (e) {
      return [];
    }
  }
}
