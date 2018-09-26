import 'package:discoucher/screens/details/establishment-item.dart';
import 'package:flutter/material.dart';

buildEstablishmentContact(
    {@required Function tapEvent,
    @required IconData icon,
    @required String displayText}) {
  if (displayText == null) {
    displayText = "";
  }

  return displayText.length < 1
      ? Container()
      : GestureDetector(
          onTap: tapEvent,
          child: buildEstablishmentItem(icon, displayText),
        );

  // var list = new ListView.builder(
  //   scrollDirection: Axis.vertical,
  //   shrinkWrap: true,
  //   padding: new EdgeInsets.all(8.0),
  //   itemExtent: 1.0,
  //   itemBuilder: (BuildContext context, int index) {
  //     return buildEstablishmentItem(icon, index.toString());
  //   },
  // );

  // return displayText.length < 1
  //     ? Container()
  //     : Column(
  //         children: <Widget>[
  //           GestureDetector(
  //             onTap: tapEvent,
  //             // child: buildEstablishmentItem(icon, displayText),
  //             child: list,
  //           )
  //         ],
  //       );
}
