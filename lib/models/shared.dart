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
  String firstName;
  String lastName;
  DateTime dob;

  String email;
  String photoUrl;

  Uint8List bytes;
  String token;
  String phoneNumber;

  String vouchers;

  LoggedInUser({
    this.id,
    this.fullName,
    this.firstName,
    this.lastName,
    this.dob,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.bytes,
    this.token,
    this.vouchers,
  });

  LoggedInUser.fromJsonMap(Map map)
      : id = map['id'],
        fullName = map['fullName'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        dob = map['dob'],
        email = map['email'],
        phoneNumber = map['phoneNumber'],
        photoUrl = map['photoUrl'],
        bytes = map['bytes'],
        token = map['token'],
        vouchers = map['vouchers'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        "fullName": fullName,
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "email": email,
        "phoneNumber": phoneNumber,
        "photoUrl": photoUrl,
        "bytes": bytes,
        "token": token,
        "vouchers":vouchers,
      };
}
