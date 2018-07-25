import 'dart:async';
import 'dart:convert';
import 'package:discoucher/models/facebook-user.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:discoucher/screens/shared/social-login-buttons.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DiscoucherRoutes routes = DiscoucherRoutes();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void _showMessage(String message) {
    setState(() {});
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _performLogin();
    }
  }

  void _performLogin() {
    final snackbar = SnackBar(
      content: Text('Email: $_email, password: $_password'),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          buildLoginForm(),
          SocialLoginButtons(routes, scaffoldKey),
        ],
      ),
    );
  }

  buildLoginForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (val) =>
                !val.contains('@') ? 'Not a valid email.' : null,
            onSaved: (val) => _email = val,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            validator: (val) => val.length < 6 ? 'Password too short.' : null,
            onSaved: (val) => _password = val,
            obscureText: true,
          ),
          RaisedButton(
            onPressed: _submit,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
