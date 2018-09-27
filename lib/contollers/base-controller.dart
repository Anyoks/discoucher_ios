import 'package:discoucher/contollers/http-controller.dart';

class BaseController {
  HttpController httpController = new HttpController();

  final headers = {
    "Content-Type": "application/json",
    "access-token": "v-Grn-DL7hKFY14PH26pKw",
    "client": "nko10Oif0mo_XRhjNyW82A",
    "uid": "testing672@api.com"
  };

  final anonymousHeaders = {
    "Content-Type": "application/json",
  };
}
