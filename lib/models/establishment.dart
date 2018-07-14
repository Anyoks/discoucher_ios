import 'package:discoucher/enums/enums.dart';

class DiscoucherRoot {
  final List<Datum> data;
  final Jsonapi jsonapi;

  DiscoucherRoot.fromJsonMap(Map map)
      : data = map['data'],
        jsonapi = map['jsonapi'];
}

class Datum {
  final String id;
  final EstablishmentType type;
  final Attributes attributes;

  Datum.fromJsonMap(Map map)
      : id = map['id'],
        type = map['type'],
        attributes = map['attributes'];
}

class Attributes {
  final String name;
  final Area area;
  final String location;
  final EstType estType;
  final String logo;
  final String featuredImage;
  final List<String> pictures;

  Attributes.fromJsonMap(Map map)
      : name = map['name'],
        area = map['area'],
        location = map['location'],
        estType = map['est_type'],
        logo = map['logo'],
        featuredImage = map['featured_image'],
        pictures = map['pictures'];
}

class Jsonapi {
  final String version;

  Jsonapi.fromJsonMap(Map map) : version = map['version'];
}
