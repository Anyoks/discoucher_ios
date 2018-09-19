import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/voucher-details.dart';
import 'package:discoucher/screens/shared/build-image.dart';
import 'package:flutter/material.dart';

openEstablishmentDetails(BuildContext context, Voucher data) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return VoucherDetailsPage(data: data);
  }));
}

buildCategorySliverGrid(List<Voucher> vouchers) {
  return SliverGrid(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 230.0,
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      childAspectRatio: 1.0,
    ),
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        var data = vouchers[index];
        return GestureDetector(
          onTap: () {
            print("pressed");
          },
          child: buildCategoryListItem(context, data),
        );
      },
      childCount: vouchers.length,
    ),
  );
}

buildCategorySliverGrid2(List<Voucher> vouchers) {
  return SliverGrid(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    ),
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        var data = vouchers[index];
        return Center(
          child: GestureDetector(
            onTap: () {
              openEstablishmentDetails(context, data);
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
  final double xHeight = 190.0;
  final double xWidth = 189.0;
  return Container(
    // height: xHeight,
    // width: xWidth, 
    // color: Colors.red,
    // constraints: BoxConstraints.expand(),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    child: Hero(
      tag: data.establishment.data.id,
      child: Column(
        children: <Widget>[
          buildSectonContent(data),
          SizedBox(height: 7.0),
          Expanded(
            child: Text(
              // data.attributes.name,
              "FREE LUNCH MAIN COURSE when a Lunch Main Course",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(color: Colors.black, fontSize: 11.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

buildSectonContent(Voucher data) {
  final double xInnerHeight = 145.0;
  return Container( 
     height: xInnerHeight,
    decoration: new BoxDecoration(
      borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      shape: BoxShape.rectangle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: buildItemImage(data.establishment.data.attributes.featuredImage),
      ),
    ),
    child: Container(
      foregroundDecoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
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
