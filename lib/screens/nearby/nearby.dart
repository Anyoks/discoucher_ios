import 'package:flutter/material.dart';
// import 'package:location/location.dart';

class NearbyPage extends StatefulWidget {
  @override
  _NearbyPageState createState() => new _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  var currentLocation = <String, double>{};
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // getLocation(){
  //   var location = new Location();
  //   try {
  //     currentLocation = await location.getLocation;
  //   } on PlatformException {
  //     currentLocation = null;
  //   }

  //   location.onLocationChanged.listen((Map<String,double> currentLocation) {
  //     print(currentLocation["latitude"]);
  //     print(currentLocation["longitude"]);
  //     print(currentLocation["accuracy"]);
  //     print(currentLocation["altitude"]);
  //     print(currentLocation["speed"]);
  //     print(currentLocation["speed_accuracy"]); // Will always be 0 on iOS
  //   });
  // }

  @override
  Widget build(BuildContext context) {


    return new Container();
  }
}