import 'dart:async';
import 'dart:convert';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/models/establishment_type.dart';
import 'package:http/http.dart';

import 'package:discoucher/constants/endpoints.dart';
import 'package:discoucher/contollers/base-controller.dart';

class HomeController extends BaseController {

  // first fetch available establishment types/cartegories

  Future<List<EstablishmentType>> fetchAvailableTypes() async{

    String endpoint = Endpoint.availableCartegories;

    final response = await fetch(endPoint: endpoint);

    final Map<String, dynamic> parsedJson = json.decode(response.body);
    final List<dynamic> data = parsedJson['data'];

    List<EstablishmentType> _cartegoryList = data.map<EstablishmentType>((item) {
        EstablishmentType _cartegoryData = EstablishmentType.fromJson(item);
        return _cartegoryData;
    }).toList();
    
    return _cartegoryList;
  }

  Future<List<String>> fetchListOfCartegoryNames() async{
    String endpoint = Endpoint.availableCartegories;

    final response = await fetch(endPoint: endpoint);

    final Map<String, dynamic> parsedJson = json.decode(response.body);
    final List<dynamic> data = parsedJson['data'];

    List<String> _cartegoryList = data.map<String>((item) {
        EstablishmentType _cartegoryData = EstablishmentType.fromJson(item);
        String name = _cartegoryData.category;
        print("the names.........................................");
        print(name);
        print(".............................");
        return name;
    }).toList();
    
    // print("CARTEGORIES");
    // print(_cartegoryList);
    // print("CARTEGORIES");
    return _cartegoryList;
  }

  // for the new version of the app that dynamically updated available Establishment types
  Future<List<List<VoucherData>>> fetchHomeDataV2(List<String> categories) async {
       
    List<Response> responses = await Future.wait(
      categories.map((category) =>
        
        postAnonymous(endPoint: Endpoint.cartegories, payload: buildPayload(category) )),
    );

    // print("QQQQQQQQQQQQQ");
    // print(responses.toString());
    var sectionsLists =
        responses.map((response) => parseSectionData(response.body)).toList();
    print("===============");
    // print("QQQQQQQQQQQQQ" + '${sectionsLists.toString()}');
    print("===============");
    
    return sectionsLists;
  }

  Map<String,String> buildPayload( String category ){

    Map<String, String> payload = {
          // category_name = category;
          "name": category,
        };

   return payload;
  }

  Future<List<List<VoucherData>>> fetchHomeData() async {
    List<String> _endpoints = [
      Endpoint.restaurantVouchers,
      Endpoint.hotelVouchers,
      Endpoint.spaVouchers
    ];

    List<Response> responses = await Future.wait(
      _endpoints.map((endpoint) => fetch(endPoint: endpoint)),
    );

    // print("QQQQQQQQQQQQQ");
    // print(responses.toString());
    var sectionsLists =
        responses.map((response) => parseSectionData(response.body)).toList();

    return sectionsLists;
  }

  List<VoucherData> parseSectionData(String responseBody) {
    Map<String, dynamic> parsedJson = json.decode(responseBody);
    var data = parsedJson['data'];
     
    //  print("GOT JUST DATA" + data);
    try {
      var list = data.map<VoucherData>((item) {
        VoucherData _voucherData = VoucherData.fromJson(item);
        if (_voucherData.attributes.description != null) {
          _voucherData.attributes.description =
              _voucherData.attributes.description.trim().replaceAll("\n", " ");
        }
        return _voucherData;
      }).toList();

      return list;
    } catch (e) {
      return [];
    }
  }

  List<EstablishmentType> parseCartegoryData(String responseBody) {

    Map<String, dynamic> parsedJson = json.decode(responseBody);
    var data = parsedJson['data'];

    var list = data.map<EstablishmentType>((item) {
        EstablishmentType _cartegoryData = EstablishmentType.fromJson(item);
        
        return _cartegoryData;
      }).toList();

      return list;
  }

  

}
