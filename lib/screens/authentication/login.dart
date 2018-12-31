import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/contollers/auth-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/authentication/sign-up.dart';
import 'package:discoucher/screens/authentication/social-login-buttons.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:discoucher/screens/shared/wavy-header-image.dart';
import 'package:discoucher/utils/validators.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LogInPageRoute extends MaterialPageRoute {
  bool fromSplashScreen;

  LogInPageRoute({@required this.fromSplashScreen})
      : super(
          builder: (context) => LoginPage(fromSplashScreen: fromSplashScreen),
        );
}

class LoginPage extends StatefulWidget {
  final bool fromSplashScreen;

  LoginPage({@required this.fromSplashScreen});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferencesController _prefs = new SharedPreferencesController();
  final DiscoucherRoutes _routes = DiscoucherRoutes();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _controller = new AuthController();
  final Validators _validators = Validators();

  bool _obscureText = true;

  String _email;
  String _password;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.initState();
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _performLogin();
    } else {
      _showMessage('Enter a valid email and a strong password');
    }
  }

  void _performLogin() async {
    var loggedInUser = await _controller.login(_email, _password);

    print("This is the response $loggedInUser");
    // Add a better error message for failed loggins due to wrong credentials
    if (loggedInUser != null) {
      goHome(context);

      // TODO REFACTOR LOGGING IN USER TO SAVE LOGGED IN USER WITHIN THE LOGIN METHOD
      LoggedInUser _userToSave = new LoggedInUser(
        id: loggedInUser.id,
        fullName: "${loggedInUser.firstName} ${loggedInUser.firstName}",
        firstName: loggedInUser.firstName,
        lastName: loggedInUser.firstName,
        email: loggedInUser.email,
        phoneNumber: loggedInUser.phoneNumber,
        vouchers: loggedInUser.vouchers,
      );
      print("WWWWWWWWW ${loggedInUser.vouchers}");

      _prefs.updateLoggedInUser(_userToSave);
    } else {
      _showMessage(
        'There was an error loggin in. Please check your network or try again later',
        Colors.red,
      );
    }
  }

  void _showMessage(String message, [MaterialColor color = Colors.orange]) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(backgroundColor: color, content: Text(message)),
    );
  }

  goHome(BuildContext context) {
    // widget.fromSplashScreen
    //     ? Navigator.popAndPushNamed(context, _routes.homeRoute)
    //     : Navigator.pop(context);

    Navigator.popAndPushNamed(context, _routes.homeRoute);
    // Navigator.pushReplacementNamed(context, _routes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        title: AppBarTitle("Login"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              WavyHeaderImage(
                child: Image.asset(
                  "images/banner.jpg",
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: buildLoginForm(),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              //   alignment: Alignment(1.0, 1.0),
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Text(
              //       'Forgot password',
              //       textAlign: TextAlign.right,
              //       style: TextStyle(color: Colors.green[900]),
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(
                    left: 45.0, top: 15.0, bottom: 15.0, right: 15.0),
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
                ),
              ),
              SocialLoginButtons(),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("Don't have an account yet?"),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, SignUpPageRoute());
                    },
                    child: Text('Sign up', textAlign: TextAlign.right),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            initialValue: "",
            // autovalidate: true,
            decoration: const InputDecoration(
                icon: const Icon(Icons.email, color: xDiscoucherGreen),
                hintText: 'Enter your email address',
                labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validators.isValidEmail(value)
                ? null
                : 'Please enter a valid email address',
            onSaved: (val) => _email = val,
          ),
          TextFormField(
            initialValue: "",
            
            // autovalidate: true,
            decoration:  InputDecoration(
                icon: const Icon(Icons.vpn_key, color: xDiscoucherGreen),
                suffixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12.0),
                  child: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                        print("inside OBSCURE TEXT $_obscureText");
                      });
                    }, //null // _toggle(),//_toggle(),
                  ), // icon is 48px widget.
                ),
                hintText: 'Enter your password',
                labelText: 'Password'),
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            validator: (val) => val.length < 6
                ? 'Your password is too short. \n Enter a password with 6 characters or more'
                : null,
            onSaved: (val) => _password = val,
          ),
        ],
      ),
    );
  }
}
