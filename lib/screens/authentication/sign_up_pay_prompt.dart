import 'package:discoucher/models/user.dart';
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

// class SignUpPayPromptRoute extends MaterialPageRoute {
//   SignUpPayPromptRoute() : super(builder: (context) => SignUpPayPrompt(User));
// }

class SignUpPayPrompt extends StatefulWidget {
  final User user;

  SignUpPayPrompt({Key key, @required User this.user}) : super(key: key) ;
  
  // SignUpPayPrompt({Key key, this.user}) : super(key: key);
 
  @override
  _SignUpPayPromptState createState() => _SignUpPayPromptState(user);
}

class _SignUpPayPromptState extends State<SignUpPayPrompt> {
  // getting the user from the sign up screen
  
  _SignUpPayPromptState(user);
  static User user = user;
  final DiscoucherRoutes _routes = DiscoucherRoutes();
  final PaymentController _controller= new PaymentController();

  @override
  void initState() {
    //  print("THIS IS THE USER IN PAYMENT state $user");
  
    
    super.initState();
  }

  void _submit() {
    goHome();
  }

  // This method will call the payment url
   _pay(User user){
    //  LoggedInUser user = user;
    // User u = SignUpPayPrompt.user ;
    print("THIS IS THE USER IN PAYMENT SCREEN $user.firstName");
    print(user.firstName);
     String phoneNumber = user.phoneNumber;
     String desc = "$phoneNumber purchase";
     String uid = user.email;

    // print("$user");
      _makePayment(uid, desc, '0711430817');
    //return null;
  }

  void _makePayment(uid,desc,phoneNumber) async {
    var payemntResponse = await _controller.makeMobilePayment(uid, desc, phoneNumber);
    print("${payemntResponse.toString()}");

    print("VIEW NOWmade payment ${payemntResponse.status} ");

    // if (payemntResponse.success == 'true') {
    //   // if the user is signing up, then he has not paid! 
    //   // goToPaymentPrompt();
    //   print("PAYMENT");
    //   print(payemntResponse);
    //   goHome();
    //   // goHome();
    // } else {
    //   _showMessage("${payemntResponse.message}");
    // }
  }


  void _showMessage(String message, [MaterialColor color = Colors.orange]) {
    Scaffold.of(context).showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }
  void goHome() {
    Navigator.popAndPushNamed(context, _routes.homeRoute);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        WavyHeaderImage(
          child: Image.asset(
            "images/banner.jpg",
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
          margin:
              EdgeInsets.only(left: 10.0, right: 10.0),
          child: Text('Unlock & start redeeming all vouchers!',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15.0)),
        ),
        Container(
          margin:
              EdgeInsets.only(left: 35.0, top: 15.0, bottom: 15.0, right: 35.0),
          padding: const EdgeInsets.all(3.0),
          decoration:
              new BoxDecoration(border: new Border.all(color: Colors.grey)),
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
                              child: Text('3,000',                                  
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
                child: OutlineButton(
                  onPressed:_pay(widget.user),
                  padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                  borderSide: BorderSide(color: xDiscoucherGreen, width: 1.0),
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
