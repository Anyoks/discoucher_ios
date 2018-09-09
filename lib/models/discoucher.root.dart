import 'package:discoucher/models/datum.dart';
import 'package:discoucher/models/jsonapi.dart';

class DiscoucherRoot {
  List<Datum> data;
  Jsonapi jsonapi;

  DiscoucherRoot({
    this.data,
    this.jsonapi,
  });

  factory DiscoucherRoot.fromJson(Map<String, dynamic> json) =>
      new DiscoucherRoot(
        data: new List<Datum>.from(
            json["data"].map((datum) => Datum.fromJson(datum))),
        jsonapi: Jsonapi.fromJson(json["jsonapi"]),
      );

  Map<String, dynamic> toJson() => {
        "data": new List<dynamic>.from(data.map((datum) => datum.toJson())),
        "jsonapi": jsonapi.toJson(),
      };
}
