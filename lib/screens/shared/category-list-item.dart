import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/voucher-details.dart';
import 'package:flutter/material.dart';

openEstablishmentDetails(BuildContext context, Voucher data) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return VoucherDetailsPage(data: data);
  }));
}

buildListItemCategory(BuildContext context, Voucher data) {
  return Container(
    // color: Colors.redAccent,
    width: 160.0,
    margin: EdgeInsets.only(right: 12.0),
    child: new GestureDetector(
      onTap: () {
        openEstablishmentDetails(context, data);
      },
      child: Hero(
        tag: data.heroId,
        child: Column(
          children: <Widget>[
            Container(
              height: 120.0,
              alignment: Alignment(0.0, 1.0),
              margin: EdgeInsets.only(bottom: 4.0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(data.establishment.data.attributes.featuredImage.length > 0
                      ? data.establishment.data.attributes.featuredImage
                      : null),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Text(
                  "Ibis Styles",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              child: Text(
                "FREE LUNCH MAIN COURSE  dwwwdwwdwd wdwdwdwd wwdw when a Lunch Main Course ...",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: 11.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
