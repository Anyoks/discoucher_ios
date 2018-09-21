import 'package:discoucher/models/voucher.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

buildSliverAppBar(BuildContext context, Voucher voucher) {
  return SliverAppBar(
      centerTitle: true,
      pinned: true,
      expandedHeight: 180.0,
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
        title: Text(voucher.establishment.data.attributes.name),
        background: DecoratedBox(
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
      ));
}
