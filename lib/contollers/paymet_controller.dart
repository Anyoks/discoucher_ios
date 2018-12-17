import 'dart:async';
import 'dart:convert';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';
import 'package:discoucher/contollers/http-controller.dart';
import 'package:discoucher/models/payment_response.dart';

class PaymentController extends BaseController{

  HttpController httpController = new HttpController();

  Future <dynamic> makeMobilePayment(String uid, String desc, String phoneNumber) async  {

    try{

      // Create a hash of parameters to post
      Map<String, String> payload = {"phone_number": phoneNumber,"description": desc, "uid": uid};

      // Make the post request
      final response = await post(endPoint: Endpoint.pay, payload: payload);

      final Map<String, dynamic> parsedJson = json.decode(response.body);
      PaymentResponse paymentResponse =  PaymentResponse.fromJson(parsedJson);

      print("MAKING PAYMENT $parsedJson");

      if(paymentResponse.success == true){
        // payment is being processed.
        print("SUCCESS");
        return paymentResponse;
        // Make a check to see if the book has been bought.
      }else{
        print("ERROR");
        return paymentResponse;
      }
      //final Map<String, dynamic> data = parsedJson['data'];
      //final Map<String, dynamic> establishment = data['attributes'];

      

    }catch(e){
      return e;
    }

  }
}