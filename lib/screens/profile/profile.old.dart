// import 'package:discoucher/constants/strings.dart';
// import 'package:discoucher/models/shared.dart';
// import 'package:discoucher/screens/profile/profile-form.dart';
// import 'package:discoucher/screens/settings/user-avatar.dart';
// import 'package:discoucher/contollers/profile-controller.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   final LoggedInUser currentUser;

//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//   final ProfileController _controller = new ProfileController();

//   ProfilePage(this.currentUser);

//   @override
//   Widget build(BuildContext context) {
//    ProfileForm _profileForm = new ProfileForm(
//         controller: _controller,
//         currentUser: currentUser,
//         formKey: _formKey,
//         scaffoldKey: _scaffoldKey);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           appBarProfile,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16.0,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//         ),
//       ),
//       body: ListView(
//         children: <Widget>[
//           SizedBox(width: 15.0),
//           buildUserAvatar(this.currentUser),
//           SizedBox(height: 15.0),
//           Container(height: 1.0, color: Colors.grey),
//           // SizedBox(height: 15.0),
//           _profileForm,
//           SizedBox(height: 100.0),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: Theme.of(context).primaryColor,
//         tooltip: 'Select search filters',
//         onPressed: () {
//           _submit();
//         },
//         label: const Text('Save'),
//         icon: const Icon(Icons.save_alt),
//       ),
//     );
//   }

//   void _submit() {
//     final FormState form = _formKey.currentState;

//     if (form.validate()) {
//       form.save();
//       _saveProfile();
//     } else {
//       _showMessage(
//           'Mhh!! Something in your details doesn\'t sound right. Please review and correct.');
//     }
//   }

//   void _saveProfile(_user) async {
//     var savedUser = await _controller.updateUser();

//     if (savedUser != null) {
//       _showMessage('Profile successfully updated', Colors.blue);
//     } else {
//       _showMessage(
//           'There was an error saving the profile. Try again later', Colors.red);
//     }
//   }

//   void _showMessage(String message, [MaterialColor color = Colors.orange]) {
//     _scaffoldKey.currentState.showSnackBar(
//         new SnackBar(backgroundColor: color, content: new Text(message)));
//   }
// }
