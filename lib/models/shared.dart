class LoginResults {
  final bool success;
  final dynamic profile;
  String message;
  dynamic token = null;

  LoginResults({this.success, this.profile, this.message});
}
