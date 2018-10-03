import 'dart:async';

import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';
import 'package:discoucher/screens/settings/user-avatar.dart';
import 'package:discoucher/contollers/profile-controller.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePageRoute extends MaterialPageRoute {
  ProfilePageRoute(user)
      : super(builder: (context) => ProfilePage(currentUser: user));

  // @override
  // Widget buildTransitions(BuildContext context, Animation<double> animation,
  //     Animation<double> secondaryAnimation, Widget child) {
  //   return FadeTransition(opacity: animation, child: child);
  // }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, @required this.currentUser}) : super(key: key);
  final LoggedInUser currentUser;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _controller = new ProfileController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final Validators _validators = Validators();

  final int maxTexInput = 40;

  User user = new User();

  @override
  void initState() {
    super.initState();

    user.id = widget.currentUser.id;
    user.firstName = widget.currentUser.fullName.split(" ")[0];
    user.lastName = widget.currentUser.fullName.split(" ")[1];
    user.email = widget.currentUser.email;
    user.phoneNumber = widget.currentUser.phoneNumber;
    user.dob = DateTime.now();
  }

  @override
  void dispose() {
    _dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          appBarProfile,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        leading: AppBackButton(),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(width: 15.0),
          buildUserAvatar(widget.currentUser),
          SizedBox(height: 15.0),
          Container(height: 1.0, color: Colors.grey),
          // SizedBox(height: 15.0),
          buildProfileForm(),
          SizedBox(height: 100.0),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Save Profile details',
        onPressed: () {
          _submit();
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save_alt),
      ),
    );
  }

  _buildSeparatorText(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(title, style: TextStyle(fontSize: 16.0, color: xDiscoucherGreen)),
        SizedBox(height: 15.0),
      ],
    );
  }

  buildProfileForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSeparatorText("Personal Information"),
            _buildFirstName(),
            _buildLastName(),
            // _buildBirthday(),
            _buildSeparatorText("Contact Information"),
            _buildEmail(),
            _buildPhone()
          ],
        ),
      ),
    );
  }

  _buildFirstName() {
    return TextFormField(
      initialValue: user.firstName,
      autovalidate: true,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      decoration: const InputDecoration(
          icon: const Icon(Icons.person, color: xDiscoucherGreen),
          hintText: 'Enter your first and last name',
          labelText: 'First Name'),
      validator: (val) => val.isEmpty ? 'First name is required' : null,
      onSaved: (val) => user.firstName = val,
    );
  }

  _buildLastName() {
    return TextFormField(
      initialValue: user.lastName,
      autovalidate: true,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      decoration: const InputDecoration(
          icon: const Icon(Icons.person, color: xDiscoucherGreen),
          hintText: 'Enter last name',
          labelText: 'Last Name'),
      validator: (val) => val.isEmpty ? 'Last name is required' : null,
      onSaved: (val) => user.lastName = val,
    );
  }

  _buildBirthday() {
    return Row(children: <Widget>[
      new Expanded(
        child: TextFormField(
          controller: _dateController,
          autovalidate: true,
          decoration: const InputDecoration(
            icon: const Icon(Icons.date_range, color: xDiscoucherGreen),
            hintText: 'Enter your date of birth',
            labelText: 'Date of birth',
          ),
          keyboardType: TextInputType.datetime,
          validator: (val) => (_validators.isValidDob(val) || val.length < 1)
              ? null
              : 'Not a valid date',
          onSaved: (val) => user.dob = _validators.convertToDate(val),
        ),
      ),
      new IconButton(
        icon: new Icon(Icons.more_vert),
        tooltip: 'Choose date',
        onPressed: (() {
          _chooseDate(context, _dateController.text);
        }),
      )
    ]);
  }

  _buildEmail() {
    return TextFormField(
      initialValue: user.email,
      autovalidate: true,
      decoration: const InputDecoration(
          icon: const Icon(Icons.email, color: xDiscoucherGreen),
          hintText: 'Enter your email address',
          labelText: 'Email address'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => _validators.isValidEmail(value)
          ? null
          : 'Please enter a valid email address',
      onSaved: (val) => user.firstName = val,
    );
  }

  _buildPhone() {
    return TextFormField(
      initialValue: user.phoneNumber,
      autovalidate: true,
      decoration: const InputDecoration(
          icon: const Icon(Icons.phone, color: xDiscoucherGreen),
          hintText: 'Enter you phone number',
          labelText: 'Phone'),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
      ],
    );
  }

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = _validators.convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _dateController.text = _validators.fomatDate(result);
    });
  }

  void _submit() {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _saveProfile();
    } else {
      _showMessage(
          'Mhh!! Something in your details doesn\'t sound right. Please review and correct.');
    }
  }

  void _saveProfile() async {
    var savedUser = await _controller.updateUser(user);

    if (savedUser != null) {
      _showMessage('Profile successfully updated', Colors.blue);
    } else {
      _showMessage('There was an error saving the profile. Try again later');
    }
  }

  void _showMessage(String message, [MaterialColor color = Colors.orange]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }
}
