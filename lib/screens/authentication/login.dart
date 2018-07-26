import 'dart:io';

import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/screens/authentication/social-login-buttons.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final key;
  final bool fromSplashScreen;

  LoginPage({this.key, this.fromSplashScreen});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPrefefencedController prefs = new SharedPrefefencedController();
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
        leading: IconButton(
          onPressed: () {
            if (widget.fromSplashScreen) {
              //TODO: Find a better way to do this, a safe way
              exit(0);
              // SystemNavigator.pop();
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          buildLoginForm(),
          SocialLoginButtons(routes, scaffoldKey, prefs),
        ],
      ),
    );
  }

  buildLoginForm() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.0),
            child: RaisedButton(
              onPressed: _submit,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 17.0),
                ),
              ),
              color: Theme.of(context).primaryColor,
              elevation: 4.0,
              splashColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
