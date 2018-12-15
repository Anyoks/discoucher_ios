import 'package:discoucher/models/establishment-full.dart';
import 'package:discoucher/models/voucher.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final Voucher voucher;
  final EstablishmentFull establishment;

  MapWidget(this.voucher, this.establishment);

  @override
  State createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 300.0,
              height: 200.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                options: GoogleMapOptions(),
              ),
            ),
          ),
          RaisedButton(
            child: const Text('Go to London'),
            onPressed: mapController == null
                ? null
                : () {
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                      const CameraPosition(
                        bearing: 270.0,
                        target: LatLng(51.5160895, -0.1294527),
                        tilt: 30.0,
                        zoom: 17.0,
                      ),
                    ));
                  },
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
