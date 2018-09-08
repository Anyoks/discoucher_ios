import 'package:discoucher/models/attribute.dart';

class Datum {
  final String id;
  final String type;
  final Attribute attributes;

  Datum({this.id, this.type, this.attributes});

  Datum.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        type = map['type'],
        attributes = map['attributes'] == null
            ? null
            : new Attribute.fromJson(map['attributes'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'type': type, 'attributes': attributes};
}
