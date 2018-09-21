import 'package:discoucher/models/voucher.dart';

class VoucherData {
  String id;
  String type;
  Voucher attributes;

  VoucherData({
    this.id,
    this.type,
    this.attributes,
  });

  factory VoucherData.fromJson(Map<String, dynamic> json) => new VoucherData(
        id: json["id"],
        type: json["type"],
        attributes: Voucher.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}
