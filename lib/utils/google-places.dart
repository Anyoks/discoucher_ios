import 'dart:async';

import 'package:discoucher/constants/api-key.dart';
import 'package:discoucher/utils/device-location.dart';
import "package:google_maps_webservice/geocoding.dart";
import 'package:google_maps_webservice/places.dart';

class GooglePlaces {
  final _geocoding = new GoogleMapsGeocoding(APIKEY);
  final _places = new GoogleMapsPlaces(APIKEY);

// final geocoding2 = new GoogleMapsGeocoding(APIKEY, new BrowserClient());

  Future<GeocodingResult> geocodeAddress(String address) async {
    GeocodingResponse response =
        await _geocoding.searchByAddress(address + ", Kenya");

    print("---------------------------------------------");

    print(response.results.first.formattedAddress);
    print(response.status);
    print(response.errorMessage);

    return response.results.first;
  }

  Future<PlacesDetailsResponse> getPlace(String address) async {
    var place = DeviceLocation.location.then((location) {
// PlacesSearchResponse reponse = await places.searchNearbyWithRadius(new Location(31.0424, 42.421), 500);
// PlacesSearchResponse reponse = await places.searchNearbyWithRankby(new Location(31.0424, 42.421), "distance");
// PlacesSearchResponse reponse = await places.searchByText("123 Main Street");

// PlacesDetailsResponse response = await places.getDetailsByPlaceId("PLACE_ID");
// PlacesDetailsResponse response = await places.getDetailsByReference("REF");

      print(location);
      return location;
    });
    print("PLACE---------------------------------------------");

    print(place);

    return null;
  }
}
