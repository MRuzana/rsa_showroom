import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:rsa_showroom/services/location_services.dart';


class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  String? _currentCity;

  Position? get currentPosition => _currentPosition;
  String? get currentCity => _currentCity;

  Future<void> startLocationUpdates() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _currentCity = 'Permission denied';
        notifyListeners();
        return;
      }
    }

    LocationService().startListening((position) {
      updatePosition(position);
    });
  }

  void updatePosition(Position position) async {
    _currentPosition = position;
    await _updateCityName(position);
    notifyListeners();
  }

  Future<void> _updateCityName(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        _currentCity = placemarks.first.locality ?? 'Unknown city';
      } else {
        _currentCity = 'Unknown city';
      }
    } catch (e) {
      _currentCity = 'Error fetching city';
      log('Geocoding error: $e');
    }
  }
}


