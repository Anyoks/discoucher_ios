import 'dart:async';

import 'package:discoucher/constants/api-key.dart';
import 'package:discoucher/models/voucher-establishment.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:discoucher/utils/google-places.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:google_maps_webservice/places.dart' as places;

class MapWidget extends StatefulWidget {
  final VoucherEstabishment estabishment;
  MapWidget(this.estabishment);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GooglePlaces googlePlaces = new GooglePlaces();

  static Location nairobi = new Location(-1.28333, 36.81667);
  MapView mapView = new MapView();

  CameraPosition cameraPosition;
  var compositeSubscription = new CompositeSubscription();
  var staticMapProvider = new StaticMapProvider(APIKEY);
  Uri staticMapUri;

  @override
  initState() {
    super.initState();

    cameraPosition = new CameraPosition(nairobi, 2.0);
    staticMapUri = staticMapProvider.getStaticUri(nairobi, 12,
        width: 900, height: 400, mapType: StaticMapViewType.roadmap);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Container(
          height: 250.0,
          child: new Stack(
            children: <Widget>[
              new Center(
                  child: new Container(
                child: new Text(
                  "You are supposed to see a map here.\n\nAPI Key is not valid.\n\n"
                      "To view maps in the example application set the "
                      "API_KEY variable in example/lib/main.dart. "
                      "\n\nIf you have set an API Key but you still see this text "
                      "make sure you have enabled all of the correct APIs "
                      "in the Google API Console. See README for more detail.",
                  textAlign: TextAlign.center,
                ),
                padding: const EdgeInsets.all(20.0),
              )),
              new InkWell(
                child: new Center(
                  child: new Image.network(staticMapUri.toString()),
                ),
                onTap: showMap,
              )
            ],
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(top: 10.0),
          child: new Text(
            "Tap the map to interact",
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(top: 25.0),
          child: new Text(
              "Camera Position: \n\nLat: ${cameraPosition.center.latitude}\n\nLng:${cameraPosition.center.longitude}\n\nZoom: ${cameraPosition.zoom}"),
        ),
      ],
    );
  }

  //Marker bubble
  List<Marker> _markers = <Marker>[
    new Marker(
      "1",
      "Something fragile!",
      -1.28333, 37.81667,
      color: Colors.blue,
      draggable: true, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/map-pointer.png",
        width: 75.0,
        height: 75.0,
      ),
    ),
  ];

  showMap() {
    var est = widget.estabishment;

    String address = "${est.name}, ${est.area}, ${est.location}, Kenya ";
    googlePlaces.geocodeAddress(address);
    googlePlaces.getPlace(address);

    mapView.show(
        new MapOptions(
          mapViewType: MapViewType.normal,
          showUserLocation: true,
          showMyLocationButton: true,
          showCompassButton: true,
          initialCameraPosition: new CameraPosition(nairobi, 15.0),
          hideToolbar: false,
          title: widget.estabishment.name,
        ),
        toolbarActions: [new ToolbarAction("Done", 1)]);

    StreamSubscription sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(_markers);
    });

    sub = mapView.onMapTapped
        .listen((location) => print("Touched location $location"));
    compositeSubscription.add(sub);

    sub = mapView.onCameraChanged.listen((cameraPosition) =>
        this.setState(() => this.cameraPosition = cameraPosition));
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
    double zoomLevel = await mapView.zoomLevel;
    Location centerLocation = await mapView.centerLocation;
    List<Marker> visibleAnnotations = await mapView.visibleAnnotations;
    print("Zoom Level: $zoomLevel");
    print("Center: $centerLocation");
    print("Visible Annotation Count: ${visibleAnnotations.length}");
    var uri = await staticMapProvider.getImageUriFromMap(mapView,
        width: 900, height: 400);
    setState(() => staticMapUri = uri);
    mapView.dismiss();
    compositeSubscription.cancel();
  }

  Future _updateRestaurantsAroundUser() async {
    //1. Ask the mapView for the center lat,lng of it's viewport.
    var mapCenter = await mapView.centerLocation;
    //2. Search for restaurants using the Places API
    var placeApi = new places.GoogleMapsPlaces(APIKEY);
    var placeResponse = await placeApi.searchNearbyWithRadius(
        new places.Location(mapCenter.latitude, mapCenter.longitude), 200,
        type: "restaurant");

    if (placeResponse.hasNoResults) {
      print("No results");
      return;
    }
    var results = placeResponse.results;

    //3. Call our _updateMarkersFromResults method update the pins on the map
    _updateMarkersFromResults(results);

    //4. Listen for the onInfoWindowTapped callback so we know when the user picked a favorite.
    var sub = mapView.onInfoWindowTapped.listen((m) {
      var selectedResult = results.firstWhere((r) => r.id == m.id);
      if (selectedResult != null) {
        _addPlaceToFavorites(selectedResult);
      }
    });
    compositeSubscription.add(sub);
  }

  void _updateMarkersFromResults(List<places.PlacesSearchResult> results) {
    //1. Turn the list of `PlacesSearchResult` into `Markers`
    var markers = results
        .map((r) => new Marker(
            r.id, r.name, r.geometry.location.lat, r.geometry.location.lng))
        .toList();

    //2. Get the list of current markers
    var currentMarkers = mapView.markers;

    //3. Create a list of markers to remove
    var markersToRemove = currentMarkers.where((m) => !markers.contains(m));

    //4. Create a list of new markers to add
    var markersToAdd = markers.where((m) => !currentMarkers.contains(m));

    //5. Remove the relevant markers from the map
    markersToRemove.forEach((m) => mapView.removeMarker(m));

    //6. Add the relevant markers to the map
    markersToAdd.forEach((m) => mapView.addMarker(m));
  }

  _addPlaceToFavorites(places.PlacesSearchResult result) {
    var staticMapProvider = new StaticMapProvider(APIKEY);
    var marker = new Marker(result.id, result.name,
        result.geometry.location.lat, result.geometry.location.lng);
    var url = staticMapProvider
        .getStaticUriWithMarkers([marker], width: 340, height: 120);

    print(result.name);
    print(url);

    // var favorite = new Favorite(result.name, result.geometry.location.lat,
    //     result.geometry.location.lat, result.vicinity, url.toString());
    // widget.manager.addFavorite(favorite);

    mapView.dismiss();
    compositeSubscription.cancel();
  }
}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}
