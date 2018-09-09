
import 'package:discoucher/models/establishment.dart';

class DatumAttributes {
  String code;
  String description;
  String condition;
  Establishment establishment;

  DatumAttributes({
    this.code,
    this.description,
    this.condition,
    this.establishment,
  });

  factory DatumAttributes.fromJson(Map<String, dynamic> json) =>
      new DatumAttributes(
        code: json["code"],
        description: json["description"],
        condition: json["condition"],
        establishment: Establishment.fromJson(json["establishment"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "condition": condition,
        "establishment": establishment.toJson(),
      };
}
