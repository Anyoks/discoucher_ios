import 'package:discoucher/models/tag.dart';

class TagData {
  String id;
  Type type;
  Tag attributes;

  TagData({
    this.id,
    this.type,
    this.attributes,
  });

  factory TagData.fromJson(Map<String, dynamic> json) => new TagData(
        id: json["id"],
        type: typeValues.map[json["type"]],
        attributes: Tag.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
        "attributes": attributes.toJson(),
      };
}

enum Type { TAGS }

final typeValues = new EnumValues({"tags": Type.TAGS});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
