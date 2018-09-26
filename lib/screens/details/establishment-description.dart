import 'package:discoucher/models/establishment-full.dart';
import 'package:flutter/material.dart';

buildEstablishmentDescription(EstablishmentFull establishment) {
  if (establishment.description == null) {
    establishment.description = "";
  }
  return Container(
    padding: EdgeInsets.all(12.0),
    child: Text(
      establishment.description,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
    ),
  );
}
