import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/models/payment_response.dart';

class PaymentController extends BaseController {
  HttpController httpController = new HttpController();

  Future<dynamic> makeMobilePayment(
      String uid, String desc, String phoneNumber) async {
    try {
      // Create a hash of parameters to post
      Map<String, String> payload = {
        "phone_number": phoneNumber,
        "description": desc,
        "uid": uid
      };

      // Make the post request
      final response = await post(endPoint: Endpoint.pay, payload: payload);
      print("MAKING REQUEST $response");
      // If the response is null, maybe there was no connection.

      if (response != null) {
        final Map<String, dynamic> parsedJson = json.decode(response.body);

        if (parsedJson['status'] == '500') {
          //error reaching the server
          return null;
        } else {
          PaymentResponse paymentResponse =
              PaymentResponse.fromJson(parsedJson);

          print("MAKING PAYMENT $parsedJson");

          if (paymentResponse.success == true) {
            // payment is being processed.
            print("SUCCESS");
            return paymentResponse;
            // Make a check to see if the book has been bought.
          } else {
            print("ERROR");
            print(" tisi it ${paymentResponse.success}");
            return paymentResponse;
          }
          //final Map<String, dynamic> data = parsedJson['data'];
          //final Map<String, dynamic> establishment = data['attributes'];
        }
      }else{
        return null;
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> checkPayment(String checkoutRequestId) async {
    try {
      // Create a hash of parameters to post
      Map<String, String> payload = {
        "checkout_req_id": checkoutRequestId,
      };

      // Make the post request
      final response =
          await postAnonymous(endPoint: Endpoint.checkPayment, payload: payload);

      final Map<String, dynamic> parsedJson = json.decode(response.body);

      if (parsedJson['status'] == '500') {
        //error reaching the server
        return null;
      } else {
        PaymentResponse paymentResponse = PaymentResponse.fromJson(parsedJson);

        print("CHECKING PAYMENT $parsedJson");
        print("CHECKING PAYMENT mdg/err ${paymentResponse.message}");
        if (paymentResponse.success == true) {
          // payment is being processed.
          print("CHECK PAYMENT SUCCESS");
          return paymentResponse;
          // Make a check to see if the book has been bought.
        } else {
          print("ERROR");
          print("CHECK PAYMENT ERROR ${paymentResponse.success}");
          return paymentResponse;
        }
        //final Map<String, dynamic> data = parsedJson['data'];
        //final Map<String, dynamic> establishment = data['attributes'];
      }
    } catch (e) {
      return e;
    }
  }
}
