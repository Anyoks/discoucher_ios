import 'package:discoucher/models/establishment-full.dart';

class EstablishmentFullDatum {
  String id;
  Type type;
  EstablishmentFull attributes;

  EstablishmentFullDatum({
    this.id,
    this.type,
    this.attributes,
  });

  factory EstablishmentFullDatum.fromJson(Map<String, dynamic> json) => new EstablishmentFullDatum(
        id: json["id"],
        type: json["type"],
        attributes: EstablishmentFull.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}
