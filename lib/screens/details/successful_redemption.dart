import 'dart:async';

import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/contollers/redeem_voucher_controller.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/loader/loader.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/models/user.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/voucher-details.dart';
import 'package:discoucher/screens/routes.dart';
import 'package:discoucher/screens/shared/styled-texts.dart';
import 'package:discoucher/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SuccessfulRedemptionPage extends StatefulWidget {
  final Voucher voucher;

  SuccessfulRedemptionPage({Key key, @required Voucher this.voucher})
      : super(key: key);
  @override
  _SuccessfulRedemptionPageState createState() =>
      _SuccessfulRedemptionPageState(voucher);
}

class _SuccessfulRedemptionPageState extends State<SuccessfulRedemptionPage> {
  _SuccessfulRedemptionPageState(this.voucher);
  final Voucher voucher;
  final int maxTexInput = 1;
  final Validators _validators = Validators();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RedeemVoucherController _controller = new RedeemVoucherController();
  static SharedPreferencesController _prefs = new SharedPreferencesController();
  final SettingsController controller = new SettingsController(prefs: _prefs);
  final DiscoucherRoutes _routes = DiscoucherRoutes();

  bool checkRedeemStatus;

  Future<LoggedInUser> loggedInUser;
  LoggedInUser loggedInUser2;
  LoggedInUser user;

  String est_pin = '';
  String email;

  double rating = 0.0;
  String comment;
  bool rated;

  var error = new TextEditingController();

  int counter = 0;

  @override
  initState() {
    super.initState();
    checkRedeemStatus = false;
    rated = false;
    loggedInUser = controller.checkLoggedIn();
    // loggedInUser2 = _prefs.fetchLoggedInUser();
    getuser();
  }

  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   print("DEPENDENCIES CHANGED SUCCESS REDEMPTION");

  // }

  void updateProgress() {
    setState(() {
      checkRedeemStatus = !checkRedeemStatus;
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
              // error.text = "User not Logged IN";
            });
          }
        }
      }
    });
  }

  void _submit() {
    FocusScope.of(context).requestFocus(new FocusNode());
    updateProgress();

    if (user != null) {
      // user os logged in proceed
      final FormState form = formKey.currentState;
      print(voucher.code);
      print(user.email);
      print(rating);
      if (form.validate()) {
        form.save();

        postCommentAndRating(voucher.code, rating, comment);
      } else {
        updateProgress();
        // _showMessage(
        //   'Mhh!! Something in your details doesn\'t sound right. Please review and correct.',
        // );
        print("eRROR VALIDATING FORM");
      }
    }
  }

  postCommentAndRating(
      String voucherCode, double rating, String comment) async {
    // TODO MAKE SERVER ENDPOINT FOR COMMENTS.
    print("RATING DETAILS");
    print("CODE $voucherCode, RATING: $rating, COMMENT: $comment");
    var rate = await _controller.rateExpirience(voucherCode, rating, comment);

    if (rate.success) {
      setState(() {
        rated = true;
      });
    }

    print("RATING RESPONSE");
    print("$rate");
    //go back to voucher page
    goToVoucherDetailsPage();
  }

  goToVoucherDetailsPage() {
    Future.delayed(const Duration(seconds: 2), (){Navigator.of(context).pop();});
    // new Timer(const Duration(seconds: 1), () {
    //   if (counter == 3) {
    //     updateProgress();
    //     Navigator.of(context).pop();
    //   } else {
    //     counter++;
    //     goToVoucherDetailsPage();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset("images/process/redeem.png", height: 40.0),
              SizedBox(width: 17.0),
              boldGreenCenterText("Voucher Redeemed Successfully."),
            ],
          ),
        ),
        Divider(color: Colors.green[900]),
        SizedBox(height: 10.0),
        Text("How was your expirience?", textAlign: TextAlign.center),
        SmoothStarRating(
          allowHalfRating: true,
          onRatingChanged: (v) {
            rating = v;
            print(rating);
            setState(() {
              // print()
            });
          },
          starCount: 5,
          rating: rating,
          size: 40.0,
          color: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).primaryColor,
        ),
        SizedBox(height: 8.0),
        buildEstablishmentest_pinInput(),
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
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: rated
                    ? Image.asset(
                        "images/icon.png",
                        fit: BoxFit.contain,
                      ) : checkRedeemStatus
                    ? Loader()
                    : RaisedButton(
                        shape:  new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: _submit,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '    Rate    ',
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
      // decoration: new BoxDecoration(border: new Border(bottom: BorderSide(color: Colors.grey ))),
      // padding: EdgeInsets.all(3.0),
      // padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        initialValue: "",
        // inputFormatters: [new LengthLimitingTextInputFormatter(maxTexInput)],
        // autovalidate: true,
        decoration: const InputDecoration(
          // icon: const Icon(Icons.email, color: xDiscoucherGreen),
          hintText: 'Great expirience...',
        ),
        keyboardType: TextInputType.text,
        validator: (val) => val.isEmpty ? 'X' : null,
        onSaved: (val) {
          comment = val;
          print("this is the comment " + comment);
        },
      ),
    ));
  }
}
