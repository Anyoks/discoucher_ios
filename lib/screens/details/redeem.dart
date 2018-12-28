import 'dart:async';

import 'package:discoucher/constants/colors.dart';
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
  final Validators _validators = Validators();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RedeemVoucherController _controller = new RedeemVoucherController();
  static SharedPreferencesController _prefs = new SharedPreferencesController();
  final SettingsController controller = new SettingsController(prefs: _prefs);
  Timer _timer;
  

  bool _isButtonDisabled;
  bool checkRedeemStatus;

  Future<LoggedInUser> loggedInUser;
  LoggedInUser loggedInUser2;
  LoggedInUser user;

  String est_pin = '';
  String email;

  var error = new TextEditingController();

  int counter = 0;

  @override
  initState() {
    super.initState();
    checkRedeemStatus = false;
    _isButtonDisabled = false;
    loggedInUser = controller.checkLoggedIn();
    // loggedInUser2 = _prefs.fetchLoggedInUser();
    getuser();
  }

  @override
  void dispose() {
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
        print("final est_pin" + est_pin);
        _performRedeem(user.email, est_pin, voucher.code);
        est_pin = ""; // clear the est_pin
      } else {
        updateProgress();
        // _showMessage(
        //   'Mhh!! Something in your details doesn\'t sound right. Please review and correct.',
        // );
        print("eRROR VALIDATING FORM");
      }
    }
  }

  _performRedeem(uid, est_pin, voucher_code) async {
    var redeemStatus =
        await _controller.redeemVoucer(uid, voucher_code, est_pin);

    if (redeemStatus == null) {
      // couldn't reach searvers
      print("NO NWTEORK ACCESS");
    } else if (redeemStatus.success == true) {
      //success redeeming voucher
      // show success redeem page
      closeDialog();
      // showSuccessRedeemDialog(context, voucher);

      setState(() {
        error.text = "${redeemStatus.message}";
      });
      // Navigator.of(context).popAndPushNamed(showSuccessRedeemDialog( context, voucher) );

      print("SUCCESS");
    } else if (redeemStatus.success == false) {
      // voucher not valid or wrong pin
      //show failed redemption page with error
      // display error message.
      updateProgress();
      print("PIN / VOUCHER ERROR");
      setState(() {
        error.text = "${redeemStatus.message}";
      });
    }
  }

  closeDialog() {
    disableButton();
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
            decoration: InputDecoration(border: InputBorder.none),
            style: new TextStyle(color: Colors.red),
            controller: error,
          ),
        ),
        SizedBox(height: 8.0),
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
                children: <Widget>[
                  buildTextField(),
                  new SizedBox(width: 5.0),
                  buildTextField(),
                  new SizedBox(width: 5.0),
                  buildTextField(),
                  new SizedBox(width: 5.0),
                  buildTextField(),
                  new SizedBox(width: 5.0),
                  buildTextField()
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: checkRedeemStatus
                    ? Loader()
                    : RaisedButton(
                        onPressed: _isButtonDisabled ? null : _submit,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '    Done    ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
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

  buildTextField() {
    return new Flexible(
        child: Container(
      height: 50.0,
      width: 40.0,
      decoration: new BoxDecoration(border: new Border.all(color: Colors.grey)),
      // padding: EdgeInsets.all(3.0),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        initialValue: "",
        inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
        // autovalidate: true,
        // decoration: const InputDecoration(
        //     icon: const Icon(Icons.email, color: xDiscoucherGreen),
        //     hintText: 'x',
        //     ),
        keyboardType: TextInputType.number,
        validator: (val) => val.isEmpty ? 'X' : null,
        onSaved: (val) {
          est_pin = est_pin + val;
          print("this is the passwprd " + est_pin);
        },
      ),
    ));
  }
}
