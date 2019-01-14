import 'package:discoucher/models/establishment.dart';
import 'package:uuid/uuid.dart';

class Voucher {
  String code;
  String description;
  String condition;
  String redeemed;
  String favourite;
  Establishment establishment;

  String heroId = new Uuid().v4();

  Voucher({
    this.code,
    this.description,
    this.condition,
    this.redeemed,
    this.favourite,
    this.establishment,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => new Voucher(
        code: json["code"],
        description: json["description"],
        condition: json["condition"],
        redeemed: json["redeemed"],
        favourite: json["favourite"],
        establishment: Establishment.fromJson(json["establishment"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "condition": condition,
        "redeemed": redeemed,
        "favourite": favourite,
        "establishment": establishment.toJson(),
      };
}
