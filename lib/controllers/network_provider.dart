import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkProvider extends ChangeNotifier {
  bool _isOnline = true;
  bool get isOnline => _isOnline;

  late StreamSubscription<List<ConnectivityResult>>? _subscription; 

  NetworkProvider() {
    _initConnectivity();
  }

void _initConnectivity() {
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      final hasInternet = result.isNotEmpty && result.first != ConnectivityResult.none;
      if (_isOnline != hasInternet) {
        _isOnline = hasInternet;
        notifyListeners();
      }
    });
  }
  @override
  void dispose() {
    _subscription!.cancel();
    super.dispose();
  }
}