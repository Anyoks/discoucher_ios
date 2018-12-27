import 'package:discoucher/constants/colors.dart';
import 'package:discoucher/contollers/redeem_voucher_controller.dart';
import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/voucher.dart';
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

  String password = '';

  void _submit() {
    print("object");
    
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
        Text("Show the following codes:"),
        SizedBox(height: 20.0),
        // Container(
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       buildRedeemSection(
        //           Icons.chrome_reader_mode, "Book code:", "code"),
        //       SizedBox(height: 20.0),
        //       buildRedeemSection(
        //           Icons.bookmark_border, "Voucher code:", "${voucher.code}")
        //     ],
        //   ),
        // )
        Container(
          child: buildEstablishmentPasswordInput(),
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

  buildEstablishmentPasswordInput() {
    return Form(
        key: formKey,
        child: Container(
          child: Column(
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
                child: RaisedButton(
                  onPressed: _submit,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '    Done    ',
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
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
        validator: (val) => val.isEmpty ? 'input Required' : null,
        onSaved: (val) {
          password = password + val;
          print("this is the passwprd " + password);
        },
      ),
    ));
  }
}
