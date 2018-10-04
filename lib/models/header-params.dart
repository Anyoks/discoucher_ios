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

  factory HeaderParams.fromJson(Map<String, dynamic> json) => new HeaderParams(
        contentType: json["Content-Type"],
        accessToken: json["access-token"],
        client: json["client"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "Content-Type": contentType,
        "access-token": accessToken,
        "client": client,
        "uid": uid,
      };

}
