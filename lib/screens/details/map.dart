import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/utils/google-places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapWidget extends StatefulWidget {
  final Voucher voucher;
  final EstablishmentFull establishment;

  MapWidget(this.voucher, this.establishment);

  @override
  State createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  GooglePlaces googlePlaces = GooglePlaces();
  GoogleMapController controller;
  Marker _selectedMarker;
  Location _location;

  EstablishmentFull _est;
  String _address;

  @override
  void initState() {
    _est = widget.establishment;
    _address = "${_est.location}, ${_est.address}";

    initLocation();

    super.initState();
  }

  @override
  void dispose() {
    controller?.onMarkerTapped?.remove(_onMarkerTapped);
    super.dispose();
  }

  initLocation() async {
    if (!_address.contains('online')) {
      var loc = await googlePlaces.getLocation(_address);

      if (loc != null) {
        if (this.mounted) {
          setState(() {
            _location = loc;
          });
        }
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    if (this.mounted) {
      setState(() {
        this.controller = controller;
        final markerOptions = buildMarkerOptions(_location);
        controller.onMarkerTapped.add(_onMarkerTapped);
        controller.addMarker(markerOptions);
      });
    }
  }

  MarkerOptions buildMarkerOptions(Location location) {
    return MarkerOptions(
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(location.lat, location.lng),
      infoWindowText: InfoWindowText(_est.name, _address),
    );
  }

  Future<Location> getLocation() async {
    try {
      Location loc = await googlePlaces.getLocation(_address);
      return loc;
    } catch (e) {
      return null;
    }
  }

  void _onMarkerTapped(Marker marker) {
    if (_selectedMarker != null) {
      _updateSelectedMarker(
        const MarkerOptions(icon: BitmapDescriptor.defaultMarker),
      );
    }

    if (this.mounted) {
      setState(() {
        _selectedMarker = marker;
      });
    }

    _updateSelectedMarker(
      MarkerOptions(
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        ),
      ),
    );
  }

  _updateSelectedMarker(MarkerOptions changes) {
    controller.updateMarker(_selectedMarker, changes);
  }

  // void updateCamera(Location loc) {
  //   if (controller != null && _location != null) {
  //     double lat =  loc.lat;
  //     double lng = loc.lng;
  //     controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         const CameraPosition(
  //           bearing: 270.0,
  //           tilt: 30.0,
  //           zoom: 13.0,
  //           target: LatLng(lat, lng),
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return _location == null
        ? Container()
        : Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 300.0,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      options: GoogleMapOptions(
                          cameraPosition: CameraPosition(
                        target: LatLng(_location.lat, _location.lng),
                        zoom: 17.0,
                        bearing: 270.0,
                        tilt: 30.0,
                      )),
                    ),
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.ac_unit),
                //   onPressed: () {},
                // )
                // RaisedButton(
                //   child: const Text("Go to {_est.name}"),
                //   onPressed: updateCamera,
                // )
              ],
            ),
          );
  }
}
