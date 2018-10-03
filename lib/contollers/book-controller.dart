import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';

class BookController extends BaseController {
  Future<List<String>> getBookCodes() async {
    try {
      final response = await fetch(endPoint: Endpoint.singleEstablishment);

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      final Map<String, dynamic> data = parsedJson['data'];

      final bookCodes = new List<String>.from(
        data["book_codes"].map((bookCode) => bookCode),
      );

      return bookCodes;
    } catch (e) {
      return [];
    }
  }
}
