import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/contollers/auth-controller.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:discoucher/screens/shared/wavy-header-image.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:discoucher/screens/authentication/sign_up_pay_prompt.dart';

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
   static SharedPreferencesController _prefs = new SharedPreferencesController();
  final SettingsController controller = new SettingsController(prefs: _prefs);
   var counter = 0;

  // Initially password is obscure
  bool _obscureText = true;
  // add toggle view password
  // _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //     print("INSIDE OBSCURE TEXT $_obscureText");
  //   });
  // }

  final int maxTexInput = 40;
  User user = new User();
  LoggedInUser loggedInUser;

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

  // Toggles the password show status

  void _saveProfile() async {
    SignUpResults signUpResults = await _controller.signUp(user);
   
    if (signUpResults != null && signUpResults.status) {
      // if the user is signing up, then he has not paid! 
      getuser().then((data){
        goToPaymentPrompt(loggedInUser);
      });
      // goToPaymentPrompt(loggedInUser);
      // goHome();
    } else {
      _showMessage("${signUpResults.message}");
    }
  }
  Future getuser() async {
    await controller.checkLoggedIn().then((data) {
      if (this.mounted) {
        if (data != null) {
          setState(() {
            loggedInUser = data;
          });
        } else {
          // check again because the first check always retursn null
          // this is a work around.
          if (counter < 2) {
            counter++;
            getuser();
          } else {
            counter = 0;
            setState(() {
              // error.text = "LoggedInUser not Logged IN";
            });
          }
        }
      }
    });
  }

  void _showMessage(String message, [MaterialColor color = Colors.orange]) {
    scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  goHome() {
  
    Navigator.popAndPushNamed(context, _routes.homeRoute);
  }

  goToPaymentPrompt(LoggedInUser loggedInUser){
    // String hR = _routes.homeRoute.toString();
    // String pR = _routes.signUpPaymentRoute.toString();
  
    // print("This is the home route  $hR");
    // print("THis is the payment route $pR");
    // Navigator.popAndPushNamed(context, _routes.signUpPaymentRoute);
    print("USer in SIgn Up SCREEN $loggedInUser");
    Navigator.push(context, MaterialPageRoute(
            builder: (context) => SignUpPayPrompt(loggedInUser: loggedInUser)));
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
          WavyHeaderImage(
            child: Image.asset(
              "images/banner.jpg",
              fit: BoxFit.cover,
              height: 200.0,
            ),
          ),
          SizedBox(width: 15.0),
          // Container(height: 1.0, color: Colors.grey),
          buildSignUpForm(),
          // SizedBox(height: 100.0),
          Container(
            margin: EdgeInsets.only(
                left: 45.0, top: 15.0, bottom: 15.0, right: 15.0),
            child: RaisedButton(
              onPressed: _submit,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 17.0),
                ),
              ),
              color: Theme.of(context).primaryColor,
              elevation: 4.0,
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   tooltip: 'Submit details',
      //   onPressed: () {
      //     _submit();
      //   },
      //   label: const Text('Submit'),
      //   icon: const Icon(Icons.check),
      // ),
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
            // _buildConfirmPassword(), // no need for this now...
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
          hintText: 'Enter your phone number',
          labelText: 'Phone'),
      keyboardType: TextInputType.phone,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      onSaved: (val) => user.phoneNumber = val,
    );
  }

  _buildPassword() {
    return TextFormField(
      initialValue: user.password,

      // autovalidate: true,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      decoration: InputDecoration(
          icon: const Icon(Icons.vpn_key, color: xDiscoucherGreen),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(end: 12.0),
            child: IconButton(
              icon: Icon( _obscureText ? Icons.visibility_off : Icons.visibility ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                  print("inside OBSCURE TEXT $_obscureText");
                });
                
              }, //null // _toggle(),//_toggle(),
            ), // icon is 48px widget.
          ),
          hintText: 'Enter password',
          labelText: 'Password'),
      obscureText: _obscureText,
      validator: (val) => val.length < 5 ? 'Valid password is required' : null,
      onSaved: (val){ user.password = val;user.passwordConfirmation = val; }, 
      //onSaved: (val) => user.passwordConfirmation = val
    );
  }

  // _buildConfirmPassword() {
  //   return TextFormField(
  //     initialValue: user.password,
  //     obscureText: true,
  //     // autovalidate: true,
  //     inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
  //     decoration: const InputDecoration(
  //         icon: const Icon(Icons.vpn_key, color: xDiscoucherGreen),
  //         hintText: 'Enter password',
  //         labelText: 'Confirm Password'),
  //     validator: (val) => val.length < 5 ? 'Valid password is required' : null,
  //     onSaved: (val) => user.passwordConfirmation = val,
  //   );
  // }
}
