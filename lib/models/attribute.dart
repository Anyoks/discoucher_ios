// import 'package:json_annotation/json_annotation.dart';
//
// part 'attribute.g.dart';
//
// @JsonSerializable()
// class Attribute extends Object with _$AttributeSerializerMixin {
//   final String name;
//   final String area;
//   final String location;
//   @JsonKey(name: 'est_type')
//   final String estType;
//   final String logo;
//   @JsonKey(name: 'featured_image')
//   final String featuredImage;
//   final List<String> pictures;
//
// // Person(this.firstName, this.lastName, this.dateOfBirth,
// //       {this.middleName, this.lastOrder, List<Order> orders})
// //       : this.orders = orders ?? <Order>[];
//
//   Attribute(this.name, this.area, this.location, this.estType, this.logo,
//       this.featuredImage, List<String> pictures)
//       : this.pictures = pictures ?? <String>[];
//
//   factory Attribute.fromJson(Map<String, dynamic> json) =>
//       _$AttributeFromJson(json);
// }

class Attributes {
  final String name;
  final String area;
  final String location;
  final String estType;
  final String logo;
  final String featuredImage;
  final List<String> pictures;

  Attributes(this.name, this.area, this.location, this.estType, this.logo, this.featuredImage, this.pictures);

  Attributes.fromJsonMap(Map map)
      : name = map['name'],
        area = map['area'],
        location = map['location'],
        estType = map['est_type'],
        logo = map['logo'],
        featuredImage = map['featured_image'],
        pictures = map['pictures'];
}
