class EstablishmentType {
  String category; 
  String description;
  String available;  

  EstablishmentType({
    this.category,
    this.description,
    this.available,    
  });

  factory EstablishmentType.fromJson(Map<String, dynamic> json) => new EstablishmentType(
        category: json["category"],
        description: json['description'],
        available:json["available"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "description": description,
        "available": available
      };
}