class User {
  String id;
  String email;
  String first_name;
  String last_name;
  String phone_number;
  int role_id;
  String created_at;
  String updated_at;
  String provider;
  String uid;
  bool allow_password_change;

  DateTime dob;

  User(
      {this.id,
      this.email,
      this.first_name,
      this.last_name,
      this.phone_number,
      this.role_id,
      this.created_at,
      this.updated_at,
      this.provider,
      this.uid,
      this.allow_password_change});

  // dob = new DateFormat.yMd().parseStrict(map['dob']);

  User.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email'],
        first_name = map['first_name'],
        last_name = map['last_name'],
        phone_number = map['phone_number'],
        role_id = map['role_id'],
        created_at = map['created_at'],
        updated_at = map['updated_at'],
        provider = map['provider'],
        uid = map['uid'],
        allow_password_change = map['allow_password_change'];

  // map["dob"] = new DateFormat.yMd().format(contact.dob);

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
        'phone_number': phone_number,
        'role_id': role_id,
        'created_at': created_at,
        'updated_at': updated_at,
        'provider': provider,
        'uid': uid,
        'allow_password_change': allow_password_change
      };
}
