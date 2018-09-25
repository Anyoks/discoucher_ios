import 'dart:async';

import 'package:flutter/services.dart';

import 'package:location/location.dart';

class DeviceLocation {
  static Future<Map<String, double>> get location => _getLocation();

  static Future<Map<String, double>> _getLocation() async {
    try {
      Location _location = new Location();
      var currentLocation = await _location.getLocation();
      return currentLocation;
    } on PlatformException {
      return null;
    }
  }
}
