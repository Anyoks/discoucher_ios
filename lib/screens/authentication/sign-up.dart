import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/contollers/auth-controller.dart';
import 'package:discoucher/models/user.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';

class SignUpPageRoute extends MaterialPageRoute {
  SignUpPageRoute() : super(builder: (context) => SignUpPage());
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final DiscoucherRoutes _routes = DiscoucherRoutes();
  final AuthController _controller = new AuthController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final Validators _validators = Validators();

  final int maxTexInput = 40;
  User user = new User();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();

    super.dispose();
  }

  void _submit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _saveProfile();
    } else {
      _showMessage(
        'Mhh!! Something in your details doesn\'t sound right. Please review and correct.',
      );
    }
  }

  void _saveProfile() async {
    SignUpResults signUpResults = await _controller.signUp(user);

    if (signUpResults != null && signUpResults.status) {
      goHome();
    } else {
      _showMessage("${signUpResults.message}");
    }
  }

  void _showMessage(String message, [MaterialColor color = Colors.orange]) {
    scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  goHome() {
    Navigator.popAndPushNamed(context, _routes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        title: AppBarTitle("Sign up"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(width: 15.0),
          Container(height: 1.0, color: Colors.grey),
          buildSignUpForm(),
          SizedBox(height: 100.0),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Submit details',
        onPressed: () {
          _submit();
        },
        label: const Text('Submit'),
        icon: const Icon(Icons.check),
      ),
    );
  }

  buildSignUpForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        autovalidate: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFirstName(),
            _buildLastName(),
            _buildEmail(),
            _buildPhone(),
            _buildPassword(),
            _buildConfirmPassword(),
          ],
        ),
      ),
    );
  }

  _buildFirstName() {
    return TextFormField(
      initialValue: user.firstName,
      // autovalidate: true,
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
      // autovalidate: true,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      decoration: const InputDecoration(
          icon: const Icon(Icons.person, color: xDiscoucherGreen),
          hintText: 'Enter last name',
          labelText: 'Last Name'),
      validator: (val) => val.isEmpty ? 'Last name is required' : null,
      onSaved: (val) => user.lastName = val,
    );
  }

  _buildEmail() {
    return TextFormField(
      initialValue: user.email,
      // autovalidate: true,
      decoration: const InputDecoration(
          icon: const Icon(Icons.email, color: xDiscoucherGreen),
          hintText: 'Enter your email address',
          labelText: 'Email address'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => _validators.isValidEmail(value)
          ? null
          : 'Please enter a valid email address',
      onSaved: (val) => user.email = val,
    );
  }

  _buildPhone() {
    return TextFormField(
      initialValue: user.phoneNumber,
      // autovalidate: true,
      decoration: const InputDecoration(
          icon: const Icon(Icons.phone, color: xDiscoucherGreen),
          hintText: 'Enter you phone number',
          labelText: 'Phone'),
      keyboardType: TextInputType.phone,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      onSaved: (val) => user.phoneNumber = val,
    );
  }

  _buildPassword() {
    return TextFormField(
      initialValue: user.password,
      obscureText: true,
      // autovalidate: true,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      decoration: const InputDecoration(
          icon: const Icon(Icons.vpn_key, color: xDiscoucherGreen),
          hintText: 'Enter password',
          labelText: 'Password'),
      validator: (val) => val.length < 5 ? 'Valid password is required' : null,
      onSaved: (val) => user.password = val,
    );
  }

  _buildConfirmPassword() {
    return TextFormField(
      initialValue: user.password,
      obscureText: true,
      // autovalidate: true,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      decoration: const InputDecoration(
          icon: const Icon(Icons.vpn_key, color: xDiscoucherGreen),
          hintText: 'Enter password',
          labelText: 'Confirm Password'),
      validator: (val) => val.length < 5 ? 'Valid password is required' : null,
      onSaved: (val) => user.passwordConfirmation = val,
    );
  }
}
