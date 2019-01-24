import 'dart:async';
import 'dart:convert';
import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/models/redeemResponse.dart';

class RedeemVoucherController extends BaseController {
  HttpController httpController = new HttpController();

  Future<dynamic> redeemVoucer(
      String uid, String voucherCode, String estPin) async {
    try {
      // Create a hash of parameters to post
      Map<String, String> payload = {
        "est_pin": estPin,
        "voucher_code": voucherCode,
        "uid": uid
      };

      // Make the post request
      final response =
          await post(endPoint: Endpoint.redeemVoucher, payload: payload);
      print("MAKING  Redeem REQUEST $response");
      // If the response is null, maybe there was no connection.

      if (response != null) {
        final Map<String, dynamic> parsedJson = json.decode(response.body);

        if (parsedJson['status'] == '500') {
          //error reaching the server
          return null;
        } else {
          RedeemResponse redeemResponse = RedeemResponse.fromJson(parsedJson);

          print("MAKING redeemption response $parsedJson");

          if (redeemResponse.success == true) {
            // payment is being processed.
            print("SUCCESS");
            return redeemResponse;
          } else {
            print("ERROR");
            print(" ther was an eroor ${redeemResponse.success}");
            return redeemResponse;
          }
        }
      } else {
        return null;
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> rateExpirience(
      String voucherCode, double rating, String comment) async {
    try {
      // Create a hash of parameters to post
      Map<String, dynamic> payload = {
        "voucher_code": voucherCode,
        "comment": comment,
        "rating": rating
      };

      // Make the post request
      final response =
          await post(endPoint: Endpoint.rateOffers, payload: payload);

      print("MAKING RATING $response");

      if (response != null) {
        final Map<String, dynamic> parsedJson = json.decode(response.body);

        if (parsedJson['status'] == '500') {
          //error reaching the server
          return null;
        } else {
          RedeemResponse redeemResponse = RedeemResponse.fromJson(parsedJson);
          // var ratingResponse = 

          print("MAKING redeemption response $parsedJson");

          if (redeemResponse.success == true) {
            // print("SUCCESS");
            return redeemResponse;
          } else {
            print("ERROR");
            print(" ther was an eroor ${redeemResponse.success}");
            return redeemResponse;
          }
        }
      } else {
        return null;
      }
    } catch (e) {}
  }
}
