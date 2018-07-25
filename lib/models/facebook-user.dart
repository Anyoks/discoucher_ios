class FacebookProfile {
  final String id;
  final String name;
  final String first_name;
  final String last_name;
  final String email;

  FacebookProfile.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        first_name = map['first_name'],
        last_name = map['last_name'],
        email = map['email'];
}
