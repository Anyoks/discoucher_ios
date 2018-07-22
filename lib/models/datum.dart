import 'package:discoucher/models/attribute.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'datum.g.dart';
//
// @JsonSerializable()
// class Datum extends Object with _$DatumSerializerMixin {
//   final String id;
//   final String type;
//   final Attribute attributes;
//
//   Datum(this.id, this.type, this.attributes);
//
//   factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
// }

class Datum {
  final String id;
  final String type;
  final Attribute attributes;

  //Datum(this.id, this.type, this.attributes);
  Datum(this.id, this.type, this.attributes);

  Datum.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        type = map['type'],
        // type = new Attribute.fromJson(map['attributes'] as Map<String, dynamic>).estType,
        attributes = map['attributes'] == null
            ? null
            : new Attribute.fromJson(map['attributes'] as Map<String, dynamic>);

  // Map<String, dynamic> toJson2() =>
  //     {'id': id, 'type': type, 'attributes': attributes};

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'type': type, 'attributes': attributes};
}
