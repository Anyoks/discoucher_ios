// Getting headers from json responses

class HeaderParams {
  String contentType;
  String accessToken;
  String client;
  String uid;

  HeaderParams({
    this.contentType,
    this.accessToken,
    this.client,
    this.uid,
  });

// creating a class object from the json response.
  factory HeaderParams.fromJson(Map<String, dynamic> json) => new HeaderParams(
    contentType: json["Content-Type"],
    accessToken: json["access-token"],
    client: json["client"],
    uid: json["uid"],
  );

// serializing the class to json
  Map<String, dynamic> toJson() => {
    "Content-Type": contentType,
    "access-token": accessToken,
    "client": client,
    "uid": uid,
  };

}
