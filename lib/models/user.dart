// class User {
//   final String id;
//   final String email;
//   final String first_name;
//   final String last_name;
//   final String phone_number;
//   final int role_id;
//   final String created_at;
//   final String updated_at;
//   final String provider;
//   final String uid;
//   final bool allow_password_change;

//   User(
//       this.id,
//       this.email,
//       this.first_name,
//       this.last_name,
//       this.phone_number,
//       this.role_id,
//       this.created_at,
//       this.updated_at,
//       this.provider,
//       this.uid,
//       this.allow_password_change);

//   User.fromJson(Map<String, dynamic> map)
//       : id = map['id'],
//         email = map['email'],
//         first_name = map['first_name'],
//         last_name = map['last_name'],
//         phone_number = map['phone_number'],
//         role_id = map['role_id'],
//         created_at = map['created_at'],
//         updated_at = map['updated_at'],
//         provider = map['provider'],
//         uid = map['uid'],
//         allow_password_change = map['allow_password_change'];

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'email': email,
//         'first_name': first_name,
//         'last_name': last_name,
//         'phone_number': phone_number,
//         'role_id': role_id,
//         'created_at': created_at,
//         'updated_at': updated_at,
//         'provider': provider,
//         'uid': uid,
//         'allow_password_change': allow_password_change
//       };
// }

// class Data {
//   final User user;

//   Data(this.user);

//   Data.fromJson(Map<String, dynamic> map) : user = map['user'];

//   Map<String, dynamic> toJson() => {'user': user};
// }

// class Errors {
//   final List<String> email;
//   final List<String> full_messages;

//   Errors(this.email, this.full_messages);

//   Errors.fromJson(Map<String, dynamic> map)
//       : email = map['user'],
//         full_messages = map['full_messages'];

//   Map<String, dynamic> toJson() =>
//       {'email': email, 'full_messages': full_messages};
// }

// class RootObject {
//   final String status;
//   final Data data;
//   final Errors errors;

//   RootObject(this.status, this.data, this.errors);

//   RootObject.fromJson(Map<String, dynamic> map)
//       : status = map['status'],
//         data = map['data'],
//         errors = map['errors'];
//   Map<String, dynamic> toJson() =>
//       {'status': status, 'data': data, 'errors': errors};
// }
