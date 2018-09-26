import 'dart:async';

import 'package:discoucher/constants/api-key.dart';
import 'package:discoucher/utils/device-location.dart';
import "package:google_maps_webservice/geocoding.dart";
import 'package:google_maps_webservice/places.dart';

class GooglePlaces {
  final _geocoding = new GoogleMapsGeocoding(APIKEY);
  final _places = new GoogleMapsPlaces(APIKEY);

  Future<Location> getLocation(String address) async {
    String _address = address.contains("kenya") ? address : "$address, Kenya";
    GeocodingResponse response = await _geocoding.searchByAddress(_address);

    Location latLon = response.results.first.geometry.location;
    return latLon;
  }

  Future<PlacesSearchResult> getPlace(String address) async {
    try {
      PlacesSearchResponse reponse = await _places.searchByText(address);

      if (reponse.hasNoResults) {
        return null;
      }

      var results = reponse.results.first;

      return results;
    } catch (e) {
      return null;
    }
  }
}
