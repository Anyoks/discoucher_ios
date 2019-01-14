import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/build-carousel.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

buildSliverAppBar({
  BuildContext context,
  Voucher voucher,
  EstablishmentFull est,
  Function addFavorite,
  bool isFavourite,
}) {
  return SliverAppBar(
    title: Text(voucher.establishment.data.attributes.name),
    pinned: true,
    expandedHeight: 200.0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_ios),
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          String des = "";
          int lastDotIndex = voucher.description.lastIndexOf(".");
          if (lastDotIndex == voucher.description.runes.length - 1) {
            des = voucher.description.substring(0, lastDotIndex);
          } else {
            des = voucher.description;
          }

          String shareMessage =
              "$des at ${voucher.establishment.data.attributes.name} \n \n\nView more deals like these by downloading the DisCoucher app at  \n https://play.google.com/store/apps/details?id=com.discoucher.deals   \n or get more info at  \n https://www.discoucher.com";

          final RenderBox box = context.findRenderObject();
          Share.share(shareMessage,
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        },
        icon: Icon(Icons.share),
      ),
      IconButton(onPressed: isFavourite == true ? null : addFavorite, icon: isFavourite == true ? Icon(Icons.favorite, color: Colors.red, ): Icon(Icons.favorite_border))
    ],
    flexibleSpace: FlexibleSpaceBar(
      collapseMode: CollapseMode.parallax,
      background: est != null && est.pictures != null
          ? buildCarousel(est.pictures)
          : DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      voucher.establishment.data.attributes.featuredImage ??
                          "images/item-placeholder.jpg"),
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.darken),
                ),
              ),
            ),
    ),
  );
}
