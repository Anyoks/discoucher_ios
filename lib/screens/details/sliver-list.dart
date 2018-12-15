import 'package:discoucher/contollers/settings-controller.dart';
import 'package:discoucher/contollers/shared-preferences-controller.dart';
import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/screens/details/build-contact-item.dart';
import 'package:discoucher/screens/details/establishment-description.dart';
import 'package:discoucher/screens/details/establishment-item.dart';
import 'package:discoucher/screens/details/map.dart';
import 'package:flutter/material.dart';

SharedPreferencesController _prefs = new SharedPreferencesController();
final SettingsController controller = new SettingsController(prefs: _prefs);

buildSliverList(
  BuildContext context,
  Voucher voucher,
  EstablishmentFull establishment,
) {
  return SliverList(
    delegate: SliverChildListDelegate(
      <Widget>[
        Hero(
          tag: voucher.heroId,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
              child: Text(
                voucher.description.replaceAll("\n", " ").toUpperCase(),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        buildEstablishmentItem(Icons.info, voucher.condition),
        buildEstablishmentItem(
            Icons.map, "${establishment.area}, ${establishment.location}"),
        buildEstablishmentItem(Icons.location_on, establishment.address),
        buildEstablishmentContact(
            tapEvent: () {
              controller.call(establishment.phone.trim());
            },
            icon: Icons.phone,
            displayText: establishment.phone),
        buildEstablishmentContact(
          tapEvent: () {
            controller.email(establishment.email);
          },
          icon: Icons.email,
          displayText: establishment.email,
        ),
        buildEstablishmentContact(
          tapEvent: () {
            controller.browse(establishment.website);
          },
          icon: Icons.link,
          displayText: establishment.website,
        ),
        buildEstablishmentDescription(establishment),
        MapWidget(voucher, establishment),
        SizedBox(height: 40.0),
      ],
    ),
  );
}
