import 'dart:async';

import 'package:discoucher/constants/api-key.dart';
import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/utils/composite-subscription.dart';
import 'package:discoucher/utils/google-places.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:google_maps_webservice/places.dart' as places;

class MapWidget extends StatefulWidget {
  final Voucher voucher;
  final EstablishmentFull establishment;
  MapWidget(this.voucher, this.establishment);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  EstablishmentFull _est;
  String _address;

  int _zoomLevel = 4;
  int _mapHeight = 400;
  int _mapWidth = 900;

  /// 1. Get location
  /// 2. Iff successful, load map
  /// 3. If null, don't load map

  Location _location;
  Marker _marker;
  Uri staticMapUri;

  GooglePlaces googlePlaces = GooglePlaces();
  MapView mapView = MapView();
  CameraPosition cameraPosition;

  var compositeSubscription = CompositeSubscription();
  var staticMapProvider = StaticMapProvider(APIKEY);

  @override
  initState() {
    super.initState();

    initializeMap();
  }

  initializeMap() async {
    _est = widget.establishment;
    _address = "${_est.name}, ${_est.area}, ${_est.location}, ${_est.address}";

    getLocation().then((loc) async {
      if (loc != null) {
        _marker = buildMarker(loc);
        cameraPosition = CameraPosition(loc, 2.0);
        staticMapUri = buildStaticMapUri();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    staticMapUri = buildStaticMapUri();
    return staticMapUri == null
        ? Container()
        : Container(
            // height: 250.0,
            child: Stack(
              children: <Widget>[
                InkWell(
                  child: Center(
                    child: Image.network(staticMapUri.toString()),
                  ),
                  onTap: showMap,
                )
              ],
            ),
          );
  }

  Uri buildStaticMapUri() {
    return _location == null
        ? null
        : staticMapProvider.getStaticUriWithMarkersAndZoom(
            [_marker],
            center: _location,
            zoomLevel: _zoomLevel,
            width: _mapWidth,
            height: _mapHeight,
            maptype: StaticMapViewType.roadmap,
          );
  }

  buildMarker(Location location) {
    return location == null
        ? null
        : Marker(
            widget.voucher.establishment.data.id,
            "${_est.name}",
            location.latitude,
            location.longitude,
            color: Colors.redAccent,
            markerIcon: MarkerIcon(
              "images/map-pointer.png",
              width: 150.0,
              height: 150.0,
            ),
          );
  }

  Future<Location> getLocation() async {
    try {
      places.Location latLon = await googlePlaces.getLocation(_address);
      Location loc = latLon == null ? null : Location(latLon.lat, latLon.lng);

      if (this.mounted) {
        setState(() {
          _location = loc;
        });
      }
      return loc;
    } catch (e) {
      return null;
    }
  }

  showMap() async {
    if (_location == null) return;

    mapView.show(
        MapOptions(
          title: "${_est.name}",
          mapViewType: MapViewType.normal,
          showUserLocation: true,
          showMyLocationButton: true,
          showCompassButton: true,
          initialCameraPosition: CameraPosition(_location, 15.0),
          hideToolbar: false,
        ),
        toolbarActions: [ToolbarAction("Done", 1)]);

    StreamSubscription sub = mapView.onMapReady.listen((_) {
      if (_marker != null) {
        mapView.setMarkers([_marker]);
      }
    });

    sub = mapView.onMapTapped.listen((location) {
      print("Touched location $location");
    });
    compositeSubscription.add(sub);

    sub = mapView.onCameraChanged.listen((cameraPosition) {
      if (this.mounted) {
        this.setState(() => this.cameraPosition = cameraPosition);
      }
    });
    compositeSubscription.add(sub);

    sub = mapView.onAnnotationDragStart.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging started");
    });

    sub = mapView.onAnnotationDragEnd.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging ended");
    });

    sub = mapView.onAnnotationDrag.listen((markerMap) {
      var marker = markerMap.keys.first;
      var location = markerMap[marker];
      print(
          "Annotation ${marker.id} moved to ${location.latitude} , ${location.longitude}");
    });
    compositeSubscription.add(sub);

    sub = mapView.onToolbarAction.listen((id) {
      print("Toolbar button id = $id");
      if (id == 1) {
        _handleDismiss();
      }
    });
    compositeSubscription.add(sub);

    sub = mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
    compositeSubscription.add(sub);
  }

  _handleDismiss() async {
    Uri uri = await staticMapProvider.getImageUriFromMap(
      mapView,
      width: _mapWidth,
      height: _mapHeight,
      maptype: StaticMapViewType.roadmap,
    );
    if (this.mounted) {
      setState(() {
        staticMapUri = uri;
      });
    }
    mapView.dismiss();
    compositeSubscription.cancel();
  }
}
