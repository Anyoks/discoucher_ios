// import 'dart:async';

// import 'package:discoucher/constants/colors.dart';
// import 'package:discoucher/models/shared.dart';
// import 'package:discoucher/models/user.dart';
// import 'package:discoucher/contollers/profile-controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class ProfileForm extends StatefulWidget {
//   ProfileForm({
//     Key key,
//     @required this.currentUser,
//     @required this.controller,
//     @required this.scaffoldKey,
//     @required this.formKey,
//   }) : super(key: key);
//   final LoggedInUser currentUser;
//   final ProfileController controller;
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final GlobalKey<FormState> formKey;

//   @override
//   _ProfileFormState createState() => _ProfileFormState();
// }

// class _ProfileFormState extends State<ProfileForm> {
//   final TextEditingController _dateController = TextEditingController();
//   final int maxTexInput = 40;

//   User user = new User();

//   @override
//   void initState() {
//     super.initState();

//     user.id = widget.currentUser.id;
//     user.first_name = widget.currentUser.fullName.split(" ")[0];
//     user.last_name = widget.currentUser.fullName.split(" ")[1];
//     user.email = widget.currentUser.email;
//     user.dob = DateTime.now();
//   }

//   @override
//   void dispose() {
//     _dateController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.0),
//       child: Form(
//         key: widget.formKey,
//         autovalidate: true,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             _buildSeparatorText("Personal Information"),
//             _buildFirstName(),
//             _buildLastName(),
//             _buildBirthday(),
//             _buildSeparatorText("Contact Information"),
//             _buildEmail(),
//             _buildPhone()
//           ],
//         ),
//       ),
//     );
//   }

//   _buildSeparatorText(String title) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(height: 20.0),
//         Text(title, style: TextStyle(fontSize: 16.0, color: xGreenIconColor)),
//         SizedBox(height: 15.0),
//       ],
//     );
//   }

//   _buildFirstName() {
//     return TextFormField(
//       initialValue: user.first_name,
//       autovalidate: true,
//       inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
//       decoration: const InputDecoration(
//           icon: const Icon(Icons.person, color: xGreenIconColor),
//           hintText: 'Enter your first and last name',
//           labelText: 'First Name'),
//       validator: (val) => val.isEmpty ? 'First name is required' : null,
//       onSaved: (val) => user.first_name = val,
//     );
//   }

//   _buildLastName() {
//     return TextFormField(
//       initialValue: user.last_name,
//       autovalidate: true,
//       inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
//       decoration: const InputDecoration(
//           icon: const Icon(Icons.person, color: xGreenIconColor),
//           hintText: 'Enter last name',
//           labelText: 'Last Name'),
//       validator: (val) => val.isEmpty ? 'Last name is required' : null,
//       onSaved: (val) => user.last_name = val,
//     );
//   }

//   _buildBirthday() {
//     return Row(children: <Widget>[
//       new Expanded(
//         child: TextFormField(
//           controller: _dateController,
//           autovalidate: true,
//           decoration: const InputDecoration(
//             icon: const Icon(Icons.date_range, color: xGreenIconColor),
//             hintText: 'Enter your date of birth',
//             labelText: 'Date of birth',
//           ),
//           keyboardType: TextInputType.datetime,
//           validator: (val) =>
//               (widget.controller.isValidDob(val) || val.length < 1)
//                   ? null
//                   : 'Not a valid date',
//           onSaved: (val) => user.dob = widget.controller.convertToDate(val),
//         ),
//       ),
//       new IconButton(
//         icon: new Icon(Icons.more_vert),
//         tooltip: 'Choose date',
//         onPressed: (() {
//           _chooseDate(context, _dateController.text);
//         }),
//       )
//     ]);
//   }

//   _buildEmail() {
//     return TextFormField(
//       initialValue: user.email,
//       autovalidate: true,
//       decoration: const InputDecoration(
//           icon: const Icon(Icons.email, color: xGreenIconColor),
//           hintText: 'Enter your email address',
//           labelText: 'Email address'),
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) => widget.controller.isValidEmail(value)
//           ? null
//           : 'Please enter a valid email address',
//       onSaved: (val) => user.first_name = val,
//     );
//   }

//   _buildPhone() {
//     return TextFormField(
//       initialValue: user.phone_number,
//       autovalidate: true,
//       decoration: const InputDecoration(
//           icon: const Icon(Icons.phone, color: xGreenIconColor),
//           hintText: 'Enter you phone number',
//           labelText: 'Phone'),
//       keyboardType: TextInputType.phone,
//       inputFormatters: [
//         WhitelistingTextInputFormatter.digitsOnly,
//       ],
//     );
//   }

//   Future _chooseDate(BuildContext context, String initialDateString) async {
//     var now = new DateTime.now();
//     var initialDate = widget.controller.convertToDate(initialDateString) ?? now;
//     initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
//         ? initialDate
//         : now);

//     var result = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: new DateTime(1900),
//         lastDate: new DateTime.now());

//     if (result == null) return;

//     setState(() {
//       _dateController.text = widget.controller.fomatDate(result);
//     });
//   }
// }
