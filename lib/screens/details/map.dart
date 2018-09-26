import 'dart:async';

import 'package:discoucher/constants/api-key.dart';
import 'package:discoucher/models/voucher-establishment.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/utils/composite-subscription.dart';
import 'package:discoucher/utils/google-places.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:google_maps_webservice/places.dart' as places;

class MapWidget extends StatefulWidget {
  final Voucher voucher;
  MapWidget(this.voucher);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  VoucherEstabishment _est;
  String _address;

  int _zoomLevel = 4;
  int _mapHeight = 400;
  int _mapWidth = 900;

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
    _est = widget.voucher.establishment.data.attributes;
    _address = "${_est.name}, ${_est.area}, ${_est.location}";
    _location = await getLocation();

    if (_location != null) {
      cameraPosition = CameraPosition(_location, 2.0);
      _marker = await buildMarker(_location);

      staticMapUri = buildStaticMapUri();
    }
  }

  @override
  Widget build(BuildContext context) {
    staticMapUri = buildStaticMapUri();

    return Container(
      height: 250.0,
      child: Stack(
        children: <Widget>[
          // Center(
          //   child: Container(
          //     child: Text(
          //       "Map could not be loaded :(",
          //       textAlign: TextAlign.center,
          //     ),
          //     padding: const EdgeInsets.all(20.0),
          //   ),
          // ),
          InkWell(
            child: Center(
              child: FadeInImage.assetNetwork(
                placeholder: 'images/loading.gif',
                image: staticMapUri.toString(),
              ),
              // child: Image.network(
              //   staticMapUri.toString(),
              // ),
            ),
            onTap: showMap,
          )
        ],
      ),
    );
  }

  Uri buildStaticMapUri() {
    return staticMapProvider.getStaticUriWithMarkersAndZoom(
      [_marker],
      center: _location,
      zoomLevel: _zoomLevel,
      width: _mapWidth,
      height: _mapHeight,
      maptype: StaticMapViewType.roadmap,
    );
  }

  buildMarker(Location location) {
    return Marker(
      widget.voucher.establishment.data.id,
      _est.name,
      location.latitude,
      location.longitude,
      color: Colors.redAccent,
      markerIcon: MarkerIcon("images/map-pointer.png"),
    );
  }

  Future<Location> getLocation() async {
    places.Location latLon = await googlePlaces.getLocation(_address);
    if (latLon == null) {
      return null;
    }
    Location location = Location(latLon.lat, latLon.lng);
    return location;
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
      this.setState(() => this.cameraPosition = cameraPosition);
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

    setState(() {
      staticMapUri = uri;
    });

    mapView.dismiss();
    compositeSubscription.cancel();
  }
}
