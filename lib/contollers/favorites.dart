
// import 'dart:async';

// import 'package:discoucher/contollers/base-controller.dart';

// class FavoritesController extends BaseController{
// Future<Favorite> signUp(Favorite _user) async {
//     try {
//       final newUser = {
//         "email": "${_user.email}",
//         "password": "${_user.password}",
//         "password_confirmation": "${_user.passwordConfirmation}",
//         "first_name": "${_user.firstName}",
//         "last_name": "${_user.lastName}",
//         "phone_number": "${_user.phoneNumber}"
//       };
//       final payload = json.encode(newUser);

//       final response = await httpController.post(
//         endPoint: Uri.encodeFull(Endpoint.signIn),
//         headers: anonymousHeaders,
//         payload: payload,
//       );

//       final Map<String, dynamic> parsedJson = json.decode(response.body);
//       final Map<String, dynamic> data = parsedJson['data'];
//       final Map<String, dynamic> userObj = data['user'];

//       User user = User.fromJson(userObj);

//       return user;
//     } catch (e) {
//       return null;
//     }
// }