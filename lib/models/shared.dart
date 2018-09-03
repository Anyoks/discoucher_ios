class LoginResults {
  final bool success;
  final dynamic profile;
  String message;
  dynamic token;

  LoginResults({this.success, this.profile, this.message, this.token});
}

class LoggedInUser {
  final String id;
  final String fullName;
  final String email;
  final String photoUrl;
  final String token;

  LoggedInUser({
    this.id,
    this.fullName,
    this.email,
    this.photoUrl,
    this.token,
  });

  LoggedInUser.fromJsonMap(Map map)
      : id = map['id'],
        fullName = map['fullName'],
        email = map['email'],
        photoUrl = map['photoUrl'],
        token = map['token'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        "fullName": fullName,
        "email": email,
        "photoUrl": photoUrl,
        "token": token,
      };
}
