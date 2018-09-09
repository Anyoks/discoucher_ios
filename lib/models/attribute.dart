class EstablishementAttributes {
  final String name;
  final String area;
  final String location;
  final String estType;
  final String logo;
  final String featuredImage;
  final List<String> pictures;

  EstablishementAttributes(
      {this.name,
      this.area,
      this.location,
      this.estType,
      this.logo,
      this.featuredImage,
      this.pictures});

  EstablishementAttributes.fromJsonMap(Map map)
      : name = map['name'],
        area = map['area'],
        location = map['location'],
        estType = map['est_type'],
        logo = map['logo'],
        featuredImage = map['featured_image'],
        pictures = (map['pictures'] as List)?.map((e) => e as String)?.toList();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'area': area,
        'location': location,
        'est_type': estType,
        'logo': logo,
        'featured_image': featuredImage,
        'pictures': pictures
      };

  factory EstablishementAttributes.fromJson(Map<String, dynamic> map) =>
      EstablishementAttributes.fromJsonMap(map);
}
