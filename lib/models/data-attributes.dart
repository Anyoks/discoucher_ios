class DataAttributes {
  String name;
  String area;
  String location;
  String featuredImage;

  DataAttributes({
    this.name,
    this.area,
    this.location,
    this.featuredImage,
  });

  factory DataAttributes.fromJson(Map<String, dynamic> json) =>
      new DataAttributes(
        name: json["name"],
        area: json["area"],
        location: json["location"],
        featuredImage: json["featured_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "area": area,
        "location": location,
        "featured_image": featuredImage,
      };
}