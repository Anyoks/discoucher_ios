import 'dart:async';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';

class BookController extends BaseController {
  Future<List<String>> getBookCodes() async {
    try {
      final data = await httpController.fetch2(Endpoint.bookCode);
      final bookCodes = new List<String>.from(
        data["book_codes"].map((bookCode) => bookCode),
      );

      return bookCodes;
    } catch (e) {
      return null;
    }
  }
}
