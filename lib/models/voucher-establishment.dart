class VoucherEstabishment {
    String name;
    String area;
    String location;
    String address;
    String phone;
    String email;
    String website;
    String socialMedia;
    String featuredImage;

    VoucherEstabishment({
        this.name,
        this.area,
        this.location,
        this.address,
        this.phone,
        this.email,
        this.website,
        this.socialMedia,
        this.featuredImage,
    });

    factory VoucherEstabishment.fromJson(Map<String, dynamic> json) => new VoucherEstabishment(
        name: json["name"],
        area: json["area"],
        location: json["location"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        website: json["website"],
        socialMedia: json["social_media"],
        featuredImage: json["featured_image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "area": area,
        "location": location,
        "address": address,
        "phone": phone,
        "email": email,
        "website": website,
        "social_media": socialMedia,
        "featured_image": featuredImage,
    };
}

// class VoucherEstabishment {
//   String name;
//   String area;
//   String location;
//   String featuredImage;

//   VoucherEstabishment({
//     this.name,
//     this.area,
//     this.location,
//     this.featuredImage,
//   });

//   factory VoucherEstabishment.fromJson(Map<String, dynamic> json) =>
//       new VoucherEstabishment(
//         name: json["name"],
//         area: json["area"],
//         location: json["location"],
//         featuredImage: json["featured_image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "area": area,
//         "location": location,
//         "featured_image": featuredImage,
//       };
// } 