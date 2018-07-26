class LoginResults {
  final bool success;
  final dynamic profile;
  String message;
  dynamic token = null;

  LoginResults({this.success, this.profile, this.message});
}

class LoggedInUser {
  final String id;
  final dynamic userData;
  LoggedInUser({this.id, this.userData});

  LoggedInUser.fromJsonMap(Map map)
      : id = map['id'],
        userData = map['userData'];

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, "userData": userData};
}
