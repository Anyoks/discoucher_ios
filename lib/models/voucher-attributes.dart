import 'package:discoucher/models/establishment.dart';

class VoucherAttributes {
  String code;
  String description;
  String condition;
  Establishment establishment;

  VoucherAttributes({
    this.code,
    this.description,
    this.condition,
    this.establishment,
  });

  factory VoucherAttributes.fromJson(Map<String, dynamic> json) =>
      new VoucherAttributes(
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
