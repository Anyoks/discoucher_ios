import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Center(child: Text("Nearby"));
  }
}
