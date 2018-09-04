import 'dart:typed_data';

class LoginResults {
  final bool success;
  final dynamic profile;
  String message;
  dynamic token;

  LoginResults({this.success, this.profile, this.message, this.token});
}

class LoggedInUser {
  String id;
  String fullName;
  String email;
  String photoUrl;
  String token;

  String firstName;
  String lastName;
  DateTime dob;
  Uint8List bytes;

  LoggedInUser({
    this.id,
    this.fullName,
    this.email,
    this.photoUrl,
    this.bytes,
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
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "photoUrl": photoUrl,
        "token": token,
      };
}
