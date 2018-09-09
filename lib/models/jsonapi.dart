class Jsonapi {
    String version;

    Jsonapi({
        this.version,
    });

    factory Jsonapi.fromJson(Map<String, dynamic> json) => new Jsonapi(
        version: json["version"],
    );

    Map<String, dynamic> toJson() => {
        "version": version,
    };
}
