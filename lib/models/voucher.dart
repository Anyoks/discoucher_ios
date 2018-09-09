import 'package:discoucher/models/establishment.dart';

class Voucher {
  String code;
  String description;
  String condition;
  Establishment establishment;

  Voucher({
    this.code,
    this.description,
    this.condition,
    this.establishment,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) =>
      new Voucher(
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
