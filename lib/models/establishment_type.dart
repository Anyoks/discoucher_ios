class EstablishmentType {
  String category; 
  String description;
  bool available;  

  EstablishmentType({
    this.category,
    this.description,
    this.available,    
  });

  factory EstablishmentType.fromJson(Map<String, dynamic> json) => new EstablishmentType(
        category: json["attributes"]["category"],
        description: json["attributes"]['description'],
        available:json["attributes"]["available"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "description": description,
        "available": available
      };
}