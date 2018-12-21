import 'dart:async';

import 'package:discoucher/constants/api-key.dart';
import "package:google_maps_webservice/geocoding.dart";
import 'package:google_maps_webservice/places.dart';

class GooglePlaces {
  final _geocoding = new GoogleMapsGeocoding();//new GoogleMapsGeocoding(APIKEY);
  final _places = new GoogleMapsPlaces();//new GoogleMapsPlaces(APIKEY);

  Future<Location> getLocation(String address) async {
    try {
      String _address = address.contains("kenya") ? address : "$address, Kenya";
      GeocodingResponse response = await _geocoding.searchByAddress(_address);
      Location latLon = response.results.first.geometry.location;

      return latLon;
    } catch (e) {
      return null;
    }
  }

  Future<PlacesSearchResult> getPlace(String address) async {
    try {
      PlacesSearchResponse reponse = await _places.searchByText(address);
      return reponse.hasNoResults ? null : reponse.results.first;
    } catch (e) {
      return null;
    }
  }
}
