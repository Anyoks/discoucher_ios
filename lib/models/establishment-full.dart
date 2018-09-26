
class Establishment {
    String name;
    String area;
    String location;
    String estType;
    String address;
    String phone;
    String email;
    String website;
    String socialMedia;
    String description;
    String logo;
    String featuredImage;
    List<String> pictures;

    Establishment({
        this.name,
        this.area,
        this.location,
        this.estType,
        this.address,
        this.phone,
        this.email,
        this.website,
        this.socialMedia,
        this.description,
        this.logo,
        this.featuredImage,
        this.pictures,
    });

    factory Establishment.fromJson(Map<String, dynamic> json) => new Establishment(
        name: json["name"],
        area: json["area"],
        location: json["location"],
        estType: json["est_type"],
        address: json["address"] == null ? null : json["address"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        website: json["website"] == null ? null : json["website"],
        socialMedia: json["social_media"] == null ? null : json["social_media"],
        description: json["description"],
        logo: json["logo"],
        featuredImage: json["featured_image"],
        pictures: new List<String>.from(json["pictures"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "area": area,
        "location": location,
        "est_type": estType,
        "address": address == null ? null : address,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "website": website == null ? null : website,
        "social_media": socialMedia == null ? null : socialMedia,
        "description": description,
        "logo": logo,
        "featured_image": featuredImage,
        "pictures": new List<dynamic>.from(pictures.map((x) => x)),
    };
}
