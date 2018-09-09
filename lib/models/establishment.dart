import 'package:discoucher/models/data.dart';

class Establishment {
  Data data;

  Establishment({
    this.data,
  });

  factory Establishment.fromJson(Map<String, dynamic> json) =>
      new Establishment(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}
