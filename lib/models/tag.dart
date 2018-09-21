import 'dart:convert';

Tag tagsFromJson(String str) {
  final jsonData = json.decode(str);
  return Tag.fromJson(jsonData);
}

String tagToJson(Tag data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Tag {
  String name;
  String image;
  int searchFreq;

  Tag({this.name, this.image, this.searchFreq});

  factory Tag.fromJson(Map<String, dynamic> json) => new Tag(
        name: json["name"],
        image: json["image"],
        searchFreq: json["search_freq"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "search_freq": searchFreq,
      };
}
