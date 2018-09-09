import 'package:discoucher/models/data-attributes.dart';

class Data {
  String id;
  String type;
  DataAttributes attributes;

  Data({
    this.id,
    this.type,
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
        id: json["id"],
        type: json["type"],
        attributes: DataAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}