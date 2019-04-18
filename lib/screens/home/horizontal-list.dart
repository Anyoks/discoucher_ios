import 'package:discoucher/contollers/home-controller.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/home/home-section-title.dart';
import 'package:discoucher/screens/shared/generic-list-item.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:recase/recase.dart';

final _homeController = new HomeController();
List<String> categories;

Widget buildHomeList(BuildContext context, List<VoucherData> voucherDataList, int index, List<String> categories) {
  
  String header = "";
  String rawHeader= "";

  // update header based on title
  rawHeader = categories[index];
  ReCase rc = new ReCase(rawHeader);
  header = rc.titleCase;

  return new Container(
    margin: EdgeInsets.only(top: 5.0),// EdgeInsets.only(left: 12.0, top: 5.0),
    child: Column(
      children: <Widget>[
        buildHomeSectionTitle(context, voucherDataList, header),
        Container(
          height: 155.0,
          child: ListView.builder(
            key: new Key(new Uuid().v1()),
            scrollDirection: Axis.horizontal,
            itemCount: voucherDataList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildGenericListItem(context, voucherDataList[index]);
            },
          ),
        ),
      ],
    ),
  );
}
