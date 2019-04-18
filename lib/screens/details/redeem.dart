import 'dart:async';

import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/contollers/auth-controller.dart';
import 'package:discoucher/contollers/redeem_voucher_controller.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/loader/loader.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/redeem_success_dialog.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:discoucher/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RedeemPage extends StatefulWidget {
  final Voucher voucher;

  RedeemPage({Key key, @required Voucher this.voucher}) : super(key: key);
  @override
  _RedeemPageState createState() => _RedeemPageState(voucher);
}

class _RedeemPageState extends State<RedeemPage> {
  _RedeemPageState(this.voucher);
  final Voucher voucher;
  final int maxTexInput = 1;
  final int maxTexInput1 = 5;
  final Validators _validators = Validators();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RedeemVoucherController _controller = new RedeemVoucherController();
  static SharedPreferencesController _prefs = new SharedPreferencesController();
  final SettingsController controller = new SettingsController(prefs: _prefs);
  final AuthController authController = new AuthController();
  final focus = FocusNode();
  Timer _timer;

  bool _isButtonDisabled;
  bool checkRedeemStatus;
  bool redeemed;
  String validateForm;

  Future<LoggedInUser> loggedInUser;
  LoggedInUser user;

  String est_pin = '';
  String single_est_pin = '';
  String email;

  var error = new TextEditingController();

  var _pin1 = new TextEditingController();
  final FocusNode _focusPin1 = FocusNode();

  var _pin2 = new TextEditingController();
  final FocusNode _focusPin2 = FocusNode();

  var _pin3 = new TextEditingController();
  final FocusNode _focusPin3 = FocusNode();

  var _pin4 = new TextEditingController();
  final FocusNode _focusPin4 = FocusNode();

  var _pin5 = new TextEditingController();
  final FocusNode _focusPin5 = FocusNode();

  int counter = 0;

  @override
  initState() {
    super.initState();
    checkRedeemStatus = false;
    _isButtonDisabled = false;
    redeemed = false;
    loggedInUser = controller.checkLoggedIn();

    getuser();
  }

  @override
  void dispose() {
    _focusPin1.dispose();
    _focusPin2.dispose();
    _focusPin3.dispose();
    _focusPin4.dispose();
    _focusPin5.dispose();
    super.dispose();
  }

  void updateProgress() {
    setState(() {
      checkRedeemStatus = !checkRedeemStatus;
    });
  }

  void disableButton() {
    setState(() {
      _isButtonDisabled = !_isButtonDisabled;
    });
  }

  void getuser() async {
    await controller.checkLoggedIn().then((data) {
      if (this.mounted) {
        if (data != null) {
          setState(() {
            user = data;
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
              error.text = "User not Logged IN";
            });
          }
        }
      }
    });
  }

  void _submit() {
    var k = getuser();
    // loggedInUser2.then((data) {
    //   email = data.email;
    //   user = data;
    //   // print(email);
    // });
    // check if user is logged in first
    FocusScope.of(context).requestFocus(new FocusNode());
    updateProgress();

    if (user != null) {
      // user os logged in proceed
      final FormState form = formKey.currentState;
      print(voucher.code);
      print(user.email);
      if (form.validate()) {
        form.save();
        print("final est_pin" + single_est_pin);
        _performRedeem(user.email, single_est_pin, voucher.code);
        single_est_pin = ""; // clear the est_pin
      } else {
        updateProgress();
        // _showMessage(
        //   'Mhh!! Something in your details doesn\'t sound right. Please review and correct.',
        // );
        print("eRROR VALIDATING FORM");
      }
    }
  }

  updateLoggedInUser(String vouchers) async {
    if (user != null) {
      LoggedInUser loggedinUSer2 = new LoggedInUser(
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        fullName: "${user.firstName} ${user.firstName}",
        vouchers: vouchers,
      );

      return await authController.saveLoggedInUser(loggedinUSer2);
    }
  }

  _performRedeem(uid, est_pin, voucher_code) async {
    var redeemStatus =
        await _controller.redeemVoucer(uid, voucher_code, est_pin);

    if (redeemStatus == null) {
      // couldn't reach searvers
      setState(() {
        error.text = "Error reaching our servers";
      });
      print("NO NWTEORK ACCESS");
    } else if (redeemStatus.success == true) {
      //success redeeming voucher
      setState(() {
        widget.voucher.redeemed = "true";
        redeemed = true;
      });

      //upDATE The logged in user so that we are in the know!
      var update = await updateLoggedInUser(redeemStatus.vouchers);

      if (update) {
        // delay so that the user can see the tick that all was successful
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context, true);
        });
      } //else {
        // the user was not successfully updated

        // setState(() {
        //   // error.text = "ERROR SAVING LOGGED INUSER";
        // });
      //}
    } else if (redeemStatus.success == false) {
      // voucher not valid or wrong pin
      //show failed redemption page with error
      // display error message.
      updateProgress();
      setState(() {
        error.text = "${redeemStatus.message}";
      });
    }
  }

  closeDialog() {
    disableButton();
    //  Navigator.of(context).pop();
    showSuccessRedeemDialog(context, voucher);
    // close the pin dialog after 20 seconds because I can't figure out how to close it as I leave
    // to the comment dialog.
    _timer = new Timer(const Duration(seconds: 20), () {
      // stop because it has taken too long.
      // if (counter >= 5) {
      //   counter = 0; // reset the counter
      print("Inside timeer");
      print(counter);
      updateProgress();
      print(
          "took too long waiting for the state to change so..update mpesa state");
      Navigator.of(context).pop();
      // exit here
      // return;
      // }

      // counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset("images/process/redeem.png", height: 40.0),
              SizedBox(width: 17.0),
              boldGreenText("Redeem"),
            ],
          ),
        ),
        Divider(color: Colors.green[900]),
        SizedBox(height: 10.0),
        Text("Show this Page to the Establishment",
            textAlign: TextAlign.center),
        Container(
          child: new TextField(
            // textAlign: TextAlign.center,
            decoration: InputDecoration(border: InputBorder.none),
            style: new TextStyle(color: Colors.red),
            controller: error,
          ),
        ),
        SizedBox(height: 3.0),
        Container(
          child: buildEstablishmentest_pinInput(),
          // child:buildTextField(),
        ),
      ],
    );
  }

  buildRedeemSection(IconData icon, String title, String code) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 30.0,
              color: xDiscoucherGreen,
            ),
            SizedBox(width: 20.0),
            Flexible(
              child: boldGreenText(code),
            )
          ],
        )
      ],
    );
  }

  buildEstablishmentest_pinInput() {
    return Form(
        key: formKey,
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildSingleTextField()
                  // buildTextField("1"),
                  // new SizedBox(width: 5.0),
                  // buildTextField("2"),
                  // new SizedBox(width: 5.0),
                  // buildTextField("3"),
                  // new SizedBox(width: 5.0),
                  // buildTextField("4"),
                  // new SizedBox(width: 5.0),
                  // buildTextField("5")
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: redeemed
                    ? Image.asset(
                        "images/icon.png",
                        fit: BoxFit.contain,
                      )
                    : checkRedeemStatus
                        ? Loader()
                        : RaisedButton(
                            shape:  new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: _isButtonDisabled ? null : _submit,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                '    Redeem    ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.0),
                              ),
                            ),
                            color: Theme.of(context).primaryColor,
                            elevation: 4.0,
                          ),
              ),
            ],
          ),
        ));
  }

  buildTextField(String text) {
    switch (text) {
      case "1":
        {
          return new Flexible(
              child: Container(
            height: 50.0,
            width: 40.0,
            decoration:
                new BoxDecoration(border: new Border.all(color: Colors.grey)),
            // padding: EdgeInsets.all(3.0),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: textFormField(),
          ));
        }
      case "2":
        {
          return new Flexible(
              child: Container(
            height: 50.0,
            width: 40.0,
            decoration:
                new BoxDecoration(border: new Border.all(color: Colors.grey)),
            // padding: EdgeInsets.all(3.0),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: textFormField2(),
          ));
        }
      case "3":
        {
          return new Flexible(
              child: Container(
            height: 50.0,
            width: 40.0,
            decoration:
                new BoxDecoration(border: new Border.all(color: Colors.grey)),
            // padding: EdgeInsets.all(3.0),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: textFormField3(),
          ));
        }
      case "4":
        {
          return new Flexible(
              child: Container(
            height: 50.0,
            width: 40.0,
            decoration:
                new BoxDecoration(border: new Border.all(color: Colors.grey)),
            // padding: EdgeInsets.all(3.0),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: textFormField4(),
          ));
        }
      case "5":
        {
          return new Flexible(
              child: Container(
            height: 50.0,
            width: 40.0,
            decoration:
                new BoxDecoration(border: new Border.all(color: Colors.grey)),
            // padding: EdgeInsets.all(3.0),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: textFormField5(),
          ));
        }
    }

    // return new Flexible(
    //     child: Container(
    //   height: 50.0,
    //   width: 40.0,
    //   decoration: new BoxDecoration(border: new Border.all(color: Colors.grey)),
    //   // padding: EdgeInsets.all(3.0),
    //   padding: EdgeInsets.only(left: 10, right: 10),
    //   child: textFormField(),
    // ));
  }

  _fieldFocusChange(FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  buildSingleTextField(){
    return new Flexible(
              child: Container(
            height: 50.0,
            width: 150.0,
            child: singleLineTextForm(),
          ));
    }
  

  singleLineTextForm(){
    return TextFormField(
      autofocus: true,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput1)],
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 35),
      
      decoration:  (new InputDecoration(hintText: '- - - - -')) ,
      onFieldSubmitted: (term) {
        _fieldFocusChange(_focusPin1, _focusPin2);
      },
      keyboardType: TextInputType.number,
      validator: (val) => val.isEmpty || val.length < 5 ? ' ' : null,
      onSaved: (val) {
        single_est_pin = single_est_pin + val;
        print("this is the passwprd " + single_est_pin);
      },
    );
  }

  textFormField() {
    return TextFormField(
      autofocus: true,
      // initialValue: "",
      controller: _pin1,
      focusNode: _focusPin1,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _fieldFocusChange(_focusPin1, _focusPin2);
      },
      keyboardType: TextInputType.number,
      validator: (val) => val.isEmpty ? 'X' : null,
      onSaved: (val) {
        est_pin = est_pin + val;
        print("this is the passwprd " + est_pin);
      },
    );
  }

  textFormField2() {
    return TextFormField(
      autofocus: true,
      // initialValue: "",
      controller: _pin2,
      focusNode: _focusPin2,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _fieldFocusChange(_focusPin2, _focusPin3);
      },
      keyboardType: TextInputType.number,
      validator: (val) => val.isEmpty ? 'X' : null,
      onSaved: (val) {
        est_pin = est_pin + val;
        print("this is the passwprd " + est_pin);
      },
    );
  }

  textFormField3() {
    return TextFormField(
      autofocus: true,
      // initialValue: "",
      controller: _pin3,
      focusNode: _focusPin3,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _fieldFocusChange(_focusPin3, _focusPin4);
      },
      keyboardType: TextInputType.number,
      validator: (val) => val.isEmpty ? 'X' : null,
      onSaved: (val) {
        est_pin = est_pin + val;
        print("this is the passwprd " + est_pin);
      },
    );
  }

  textFormField4() {
    return TextFormField(
      autofocus: true,
      // initialValue: "",
      controller: _pin4,
      focusNode: _focusPin4,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _fieldFocusChange(_focusPin4, _focusPin5);
      },
      keyboardType: TextInputType.number,
      validator: (val) => val.isEmpty ? 'X' : null,
      onSaved: (val) {
        est_pin = est_pin + val;
        print("this is the passwprd " + est_pin);
      },
    );
  }

  textFormField5() {
    return TextFormField(
      autofocus: true,
      // initialValue: "",
      controller: _pin5,
      focusNode: _focusPin5,
      inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      validator: (val) => val.isEmpty ? 'X' : null,
      onSaved: (val) {
        est_pin = est_pin + val;
        print("this is the passwprd " + est_pin);
      },
    );
  }
}
