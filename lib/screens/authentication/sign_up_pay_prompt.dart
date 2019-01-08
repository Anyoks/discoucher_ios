import 'dart:async';

import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/loader/loader.dart';
import 'package:discoucher/models/user.dart';
import 'package:discoucher/screens/profile/profile.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:discoucher/screens/shared/wavy-header-image.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/contollers/paymet_controller.dart';
import 'package:discoucher/models/payment_response.dart';
// this it the first sign up payment prompt

class SignUpPayPromptRoute extends MaterialPageRoute {
  SignUpPayPromptRoute() : super(builder: (context) => SignUpPayPrompt());
}

class SignUpPayPrompt extends StatefulWidget {
  final LoggedInUser loggedInUser;

  SignUpPayPrompt({Key key, @required LoggedInUser this.loggedInUser})
      : super(key: key);

  // SignUpPayPrompt({Key key, this.user}) : super(key: key);

  @override
  _SignUpPayPromptState createState() => _SignUpPayPromptState(loggedInUser);
}

class _SignUpPayPromptState extends State<SignUpPayPrompt>
    with WidgetsBindingObserver {
  // getting the user from the sign up screen
  _SignUpPayPromptState(loggedInUser);
  static LoggedInUser loggedInUser = loggedInUser;
  final DiscoucherRoutes _routes = DiscoucherRoutes();
  final PaymentController _controller = new PaymentController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // SharedPreferencesController _prefs = new SharedPreferencesController();
  static SharedPreferencesController _prefs = new SharedPreferencesController();
  final SettingsController controller = new SettingsController(prefs: _prefs);
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkPaymentStatus;
  String checkoutRequestId;
  Timer _timer;
  bool goneToMpesaScreen; // only true when the pay now button is clicked
  AppLifecycleState _notification;
  final String countryCode = ("254".split("")).join(); // 254
  var counter = 0;
  LoggedInUser loggedInUser2;

  @override
  void initState() {
    super.initState();
    goneToMpesaScreen =
        false; // used to check whether the user is back from payment screen after clickin the pay the button
    checkPaymentStatus = false; // will be used for loading progress
    getuser();
    print("mpesa state $goneToMpesaScreen");
    WidgetsBinding.instance
        .addObserver(this); // checking if the app just came from the background
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
      print("CURRENT APP STATE from system $_notification");
    });
  }

  void getuser() async {
    await controller.checkLoggedIn().then((data) {
      if (this.mounted) {
        if (data != null) {
          setState(() {
            loggedInUser2 = data;
            // print("Updated Ulser 1" + loggedInUser2.phoneNumber);
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

  void updateProgress() {
    setState(() {
      checkPaymentStatus = !checkPaymentStatus;
    });
  }

  void updateGoneToMpesaScreen() {
    print("UPDATING THE MPESA STATE FROM  $goneToMpesaScreen");
    goneToMpesaScreen = !goneToMpesaScreen;
    print("UPDATING THE MPESA STATE to  $goneToMpesaScreen");
  }

  void _submit() {
    goHome();
  }

  // This method will call the payment url
  void _pay(LoggedInUser user) {
    getuser(); // need to update the state  just incase this is a oogle or fb login back from updating the profile.

    // there is a tarrying time before the second coming, so that all that can be saved, mustn't be lost.
    Future.delayed(const Duration(seconds: 2), () {
      if (loggedInUser2.phoneNumber == null ||
          loggedInUser2.phoneNumber == "null" ||
          loggedInUser2.phoneNumber == "") {
        _showMessageDissmiss(
            "You will be directed to you profile, Kindly update your phone Number with the Number you'll use for payments.");

        Future.delayed(const Duration(seconds: 5), () {
          Navigator.push(context, ProfilePageRoute(user));
        });
      } else {
        updateProgress();
        _notification = null;
        updateGoneToMpesaScreen(); // make it true
        // goHome();

        print("APP STATE AFTER CLICKING PAY  $_notification");

        // process user phone Number to mpesa format 254722112233
        var phoneWithoutZero = new List<String>.from(user.phoneNumber == null
            ? loggedInUser2.phoneNumber.split("")
            : user.phoneNumber.split(""));
        phoneWithoutZero.removeAt(0); // remove the 0
        String phoneNumber = countryCode +
            phoneWithoutZero.join(); //'254711430817'; //user.phoneNumber;
        print("USer in SIgn Up SCREEN ${phoneNumber}");
        String desc = "$phoneNumber mpurchase";
        String uid = user.email;

        // print("$user");
        _makePayment(uid, desc, phoneNumber);
      }
    });
  }

  _makePayment(uid, desc, phoneNumber) async {
    var payemntResponse =
        await _controller.makeMobilePayment(uid, desc, phoneNumber);

    if (payemntResponse == null) {
      // error reaching the server
      updateProgress();
      _showMessage(
          "Sorry we could not reach our servers. Check your connection and try again.");
    } else {
      //there's internet
      if (payemntResponse.success == false) {
        //error Making the payment, could be offline, or bad phone number, phone locked etc etc
        print(" The number is $phoneNumber");
        updateProgress();
        _showMessage("Sorry we could not Make the payment, try again.");
      } else {
        //add a loading thing here , to now check if the user's payment was successful
        //set the request ID
        checkoutRequestId = payemntResponse.checkoutRequestId;

        checkPayment(checkoutRequestId);

        _showSuccessMessage(
            "$_notification Your request is being processed, Kindly wait for a few seconds...");
      }
    }
  }

  // this should be refactored to be re used
  checkPayment(String checkoutRequestId) async {
    // _timer ??  _timer.cancel();
    print("CHECKING THE CURRENT STATE $_notification");
    print("CHECKING THE MPESA STATE $goneToMpesaScreen");
    if (_notification == AppLifecycleState.resumed &&
        goneToMpesaScreen == true) {
      _notification = null; // clear the notification
      print("JUST CAME NBACK FROM MPESA SCREEN SO UPDATE MPESA STATE");
      updateGoneToMpesaScreen(); // change the status so that some other resume doesn't use this.
      if (checkoutRequestId != null) {
        // _timer = new Timer(const Duration(seconds: 5), () {});
        print("CHECKING THE STATE $checkPaymentStatus");
        var checkPaymentResponse =
            await _controller.checkPayment(checkoutRequestId);

        if (checkPaymentResponse.success == true) {
          print("CHECKING THE PAYMENT SUCCESS");
          print("PROGRESS STATE $checkPaymentStatus");
          checkoutRequestId = null;

          // goHome();
          // now the user has valid voucher so update.
          updateLoggedInUser();
          // update user.vouchers here.
          // updateProgress();

          //go home
        } else {
          print("CHECKING THE PAYMENT ERROR ${checkPaymentResponse.message}");
          _notification = null;
          updateProgress();
          //error payment was not successful
          // end progress bar
          // go to error page with contact details
          //  ${checkPaymentResponse.message}"
          _showErrorMessageDissmiss(
              "Sorry we could not Make the payment. You entered the wrong password, Kindly try again");
        }
      }
    } else {
      // call itself again till the sate actually cahnges
      print("STATE HAS NOT YET CHANGED $_notification");
      _timer = new Timer(const Duration(seconds: 5), () {
        // stop because it has taken too long.
        if (counter >= 5) {
          counter = 0; // reset the counter
          updateProgress();
          print(
              "took too long waiting for the state to change so..update mpesa state");
          updateGoneToMpesaScreen();
          // exit here
          _showMessageDissmiss(
              "Sorry we could not Make the payment. Mpesa took too long to respond. Wait afew seconds and Try again.");
          return;
        }
        checkPayment(checkoutRequestId);
        print("Inside timeer");
        counter++;
      });
    }
  }

  updateLoggedInUser() async {
    print("UPDATIN USER   DONEEEEEE " + loggedInUser.email);
    if (loggedInUser != null) {
      print("UPDATIN USER   DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
      LoggedInUser _userToSave = new LoggedInUser(
        id: loggedInUser.id,
        fullName: "${loggedInUser.firstName} ${loggedInUser.firstName}",
        firstName: loggedInUser.firstName,
        lastName: loggedInUser.firstName,
        email: loggedInUser.email,
        phoneNumber: loggedInUser.phoneNumber,
        vouchers: 'valid',
      );
      print("WWWWWWWWW ${loggedInUser.vouchers}");

      var save = await _prefs.updateLoggedInUser(_userToSave);

      print("UPDATIN USER   DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE $save");
      goHome();
    }
  }

  void _showMessage(String message, [MaterialColor color = Colors.orange]) {
    // return
    scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _showMessageDissmiss(String message,
      [MaterialColor color = Colors.orange]) {
    // return
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      duration: Duration(seconds: 30),
      content: new Text(message),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    ));
  }

  void _showErrorMessageDissmiss(String message,
      [MaterialColor color = Colors.red]) {
    // return
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      duration: Duration(seconds: 30),
      content: new Text(message),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    ));
  }

  void _showSuccessMessage(String message,
      [MaterialColor color = Colors.green]) {
    // return
    scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void goHome() {
    Navigator.popAndPushNamed(context, _routes.homeRoute);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ListView(children: <Widget>[
        WavyHeaderImage(
          child: Image.asset(
            "images/almost.png",
            fit: BoxFit.cover,
            height: 200.0,
          ),
        ),
        SizedBox(width: 15.0),
        Container(
          child: Column(
            children: [],
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(left: 35.0, top: 15.0, bottom: 15.0, right: 35.0),
          child: RaisedButton(
            onPressed: _submit,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
              child: Text(
                'CONTINUE TO FREE VOUCHER',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
            color: Theme.of(context).primaryColor,
            elevation: 4.0,
          ),
        ),
        SizedBox(
          width: 15.0,
          height: 10.0,
        ),
        Container(
          child: Text('Or',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20)),
        ),
        SizedBox(
          width: 15.0,
          height: 20.0,
        ),
        Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text('Unlock & start redeeming all vouchers!',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15.0)),
        ),
        Container(
          margin:
              EdgeInsets.only(left: 35.0, top: 15.0, bottom: 15.0, right: 35.0),
          padding: const EdgeInsets.all(3.0),
          // decoration:
          //     new BoxDecoration(border: new Border.all(color: Colors.grey)),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(3.0),
                              child: Text('KES',
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20))),
                          Container(
                              padding: EdgeInsets.all(0),
                              child: Text('2,000',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 55.0))),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                      alignment: Alignment(0.0, 0.0),
                    ),
                    //),
                  ]),
              Text('/year',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
              SizedBox(
                width: 15.0,
                height: 40.0,
              ),
              SizedBox(
                width: double.infinity,
                child: checkPaymentStatus
                    ? Loader()
                    : OutlineButton(
                        onPressed: () => _pay(widget.loggedInUser),
                        padding: EdgeInsets.symmetric(
                            horizontal: 36.0, vertical: 12.0),
                        borderSide:
                            BorderSide(color: xDiscoucherGreen, width: 1.0),
                        child: boldGreenText("Pay Now"),
                      ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
