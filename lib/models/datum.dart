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
  //final Attributes attributes;

  //Datum(this.id, this.type, this.attributes);
  Datum(this.id, this.type);

  Datum.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        type = map['type'];
        //attributes = map['attributes'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
      };
}
