import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/build-carousel.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:carousel_slider/carousel_slider.dart';

buildSliverAppBar(
    BuildContext context, Voucher voucher, EstablishmentFull est) {
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
          //TODO: Add proper sharing
          // Share.share(voucher.attributes.name);
          final RenderBox box = context.findRenderObject();
          Share.share(voucher.establishment.data.attributes.name,
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        },
        icon: Icon(Icons.share),
      ),
      IconButton(
        onPressed: () {
          // TODO: Add proper favorites

          Duration timeout = new Duration(seconds: 3);
          final snackBar = SnackBar(
            duration: timeout,
            content: Text(
                "${voucher.establishment.data.attributes.name} added to favorites"),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        icon: Icon(Icons.favorite_border),
      )
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
