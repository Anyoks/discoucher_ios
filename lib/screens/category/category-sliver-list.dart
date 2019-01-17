import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/redeem-dialog.dart';
import 'package:discoucher/screens/details/voucher-details.dart';
import 'package:discoucher/screens/shared/build-image.dart';
import 'package:flutter/material.dart';

final double xHeight = 157.0;
final double xBottomTextBoxWidth = 200.0;
final xlighterTextColor = Color(0xFF4F4F4F);

buildCategorySliverList(List<VoucherData> voucherDataList) {
  return SliverFixedExtentList(
    itemExtent: 135.0,
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        Voucher data = voucherDataList[index].attributes;
        data.description = data.description.replaceAll("\n", " ");

        return Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, VoucherDetailsPageRoute( voucherDataList[index]));
            },
            child: buildCategoryListItem(context, data),
          ),
        );
      },
      childCount: voucherDataList.length,
    ),
  );
}

buildCategoryListItem(BuildContext context, Voucher data) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
    margin: EdgeInsets.symmetric(vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 120.0,
          width: 130.0,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: buildItemImage(
                data.establishment.data.attributes.featuredImage,
              ),
            ),
          ),
        ),
        SizedBox(width: 5.0),
        Expanded(child: buildCategoryContent(context, data)),
        // InkWell(
        //   onTap: () => showRedeemDialog(context, data),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       Image.asset("images/process/redeem.png", height: 25.0),
        //       SizedBox(height: 19.0),
        //       Text(
        //         "Redeem",
        //         style: TextStyle(
        //           color: Theme.of(context).primaryColor,
        //           fontSize: 12.0,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    ),
  );
}

buildCategoryContent(BuildContext context, Voucher data) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        data.establishment.data.attributes.name,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 7.0),
      Flexible(
        fit: FlexFit.loose,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: data.heroId,
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  data.description,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(color: Colors.black, fontSize: 11.0),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            buildDetailItem(
                Icons.location_on, data.establishment.data.attributes.location),
            SizedBox(height: 5.0),
            buildDetailItem(Icons.calendar_today, data.condition),
          ],
        ),
      ),
    ],
  );
}

buildDetailItem(IconData icon, String item) {
  return item == null
      ? Container()
      : Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 16.0, color: xlighterTextColor),
              SizedBox(width: 5.0),
              Container(
                width: xBottomTextBoxWidth,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: xlighterTextColor,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ],
          ),
        );
}
