class HeaderParams {
  String accept;
  String accessToken;
  String client;
  String uid;

  HeaderParams({
    this.accept,
    this.accessToken,
    this.client,
    this.uid,
  });

  factory HeaderParams.fromJson(Map<String, dynamic> json) => new HeaderParams(
        accept: json["Accept"],
        accessToken: json["access-token"],
        client: json["client"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "Accept": accept,
        "access-token": accessToken,
        "client": client,
        "uid": uid,
      };

}
