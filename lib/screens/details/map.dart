import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class MapWidget extends StatefulWidget {
  final String locationString;
  MapWidget(this.locationString);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  static const APIKEY = "AIzaSyCwwdZdbd-zVeLCeCwQrHLPpeHWYJO1XoY";

  static Location nairobi = new Location(-1.28333, 36.81667);

  _MapWidgetState() {
    MapView.setApiKey(APIKEY);
  }

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

  showMap() {
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            showMyLocationButton: true,
            showCompassButton: true,
            initialCameraPosition: new CameraPosition(nairobi, 15.0),
            hideToolbar: false,
            title: "Nairobi"),
        toolbarActions: [new ToolbarAction("Done", 1)]);
    StreamSubscription sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(_markers);
    });
    compositeSubscription.add(sub);
    sub = mapView.onLocationUpdated.listen((location) {
      print("Location updated $location");
    });
    compositeSubscription.add(sub);
    sub = mapView.onTouchAnnotation
        .listen((annotation) => print("annotation ${annotation.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onTouchPolyline
        .listen((polyline) => print("polyline ${polyline.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onTouchPolygon
        .listen((polygon) => print("polygon ${polygon.id} tapped"));
    compositeSubscription.add(sub);
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

  //Marker bubble
  List<Marker> _markers = <Marker>[
    new Marker(
      "1",
      "Something fragile!",
      -1.28333, 36.81667,
      color: Colors.blue,
      draggable: true, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/map-pointer.png",
        width: 75.0,
        height: 75.0,
      ),
    ),
  ];

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
