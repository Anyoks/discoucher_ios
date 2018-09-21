class VoucherEstabishment {
  String name;
  String area;
  String location;
  String featuredImage;

  VoucherEstabishment({
    this.name,
    this.area,
    this.location,
    this.featuredImage,
  });

  factory VoucherEstabishment.fromJson(Map<String, dynamic> json) =>
      new VoucherEstabishment(
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