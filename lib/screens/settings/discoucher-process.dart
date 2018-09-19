import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/screens/shared/app-back-button.dart';
import 'package:discoucher/screens/shared/app-bar-title.dart';
import 'package:flutter/material.dart';

class DiscoucherProcessRoute extends MaterialPageRoute {
  DiscoucherProcessRoute() : super(builder: (context) => DiscoucherProcess());
}

class DiscoucherProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        title: AppBarTitle(appBarDiscoucherProcess),
      ),
      body: new Center(
        child: Text("Discoucher Process"),
      ),
    );
  }
}
