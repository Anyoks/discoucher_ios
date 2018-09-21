import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/voucher-details.dart';
import 'package:discoucher/screens/shared/build-image.dart';
import 'package:flutter/material.dart';

final double xHeight = 157.0;
final double xBottomTextBoxWidth = 200.0;
final xlighterTextColor = Color(0xFF4F4F4F);

buildCategorySliverList(List<Voucher> vouchers) {
  return SliverFixedExtentList(
    itemExtent: 135.0,
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        var data = vouchers[index];
        return Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, VoucherDetailsPageRoute(data));
            },
            child: buildCategoryListItem(context, data),
          ),
        );
      },
      childCount: vouchers.length,
    ),
  );
}

buildCategoryListItem(BuildContext context, Voucher data) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      // borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    // height: xHeight,
    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    margin: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //buildSectonContent(data),
        Container(
          height: 120.0,
          width: 130.0,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: buildItemImage(
                  data.establishment.data.attributes.featuredImage),
            ),
          ),
        ),
        SizedBox(width: 7.0),
        Flexible(
            fit: FlexFit.loose, child: buildCategoryContent(context, data)),
        // Container(
        //   // color: Colors.red,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       Icon(Icons.next_week, color: Theme.of(context).primaryColor),
        //       SizedBox(height: 19.0),
        //       Text(
        //         "Redeem",
        //         overflow: TextOverflow.ellipsis,
        //         maxLines: 1,
        //         style: TextStyle(
        //             color: Theme.of(context).primaryColor,
        //             fontSize: 18.0,
        //             fontWeight: FontWeight.w500),
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
    crossAxisAlignment: CrossAxisAlignment.stretch,
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
              child: Text(
                data.description,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(color: Colors.black, fontSize: 11.0),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.calendar_today,
                  size: 16.0,
                  color: xlighterTextColor,
                ),
                SizedBox(width: 5.0),
                Container(
                    width: xBottomTextBoxWidth,
                    child: Text(data.condition != null ? data.condition : "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: xlighterTextColor, fontSize: 11.0))),
              ],
            ),
            SizedBox(height: 5.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 16.0,
                    color: xlighterTextColor,
                  ),
                  SizedBox(width: 5.0),
                  Container(
                    width: xBottomTextBoxWidth,
                    child: Text(
                        data.establishment.data.attributes.location != null
                            ? data.establishment.data.attributes.location
                            : "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: xlighterTextColor, fontSize: 11.0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

buildSectonContent(Voucher data) {
  final double xInnerHeight = 150.0;
  return Container(
    height: xInnerHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      shape: BoxShape.rectangle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: buildItemImage(data.establishment.data.attributes.featuredImage),
      ),
    ),
    child: Container(
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
      ),
      child: Container(
        alignment: Alignment(0.0, 1.0),
        constraints: BoxConstraints.expand(height: 44.0),
        padding: EdgeInsets.all(4.0),
        child: Text(
          data.establishment.data.attributes.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
