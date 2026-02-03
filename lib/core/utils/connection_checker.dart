// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectionChecker {
  static StreamSubscription<List<ConnectivityResult>>? _subscription;

  static Future<bool> checkConnection(BuildContext context) async {
    List<ConnectivityResult> connectionStatus = await Connectivity().checkConnectivity();
    if (connectionStatus.contains(ConnectivityResult.none)) {
      networkErrorShowSnackbar(context);
      return false;
    }
    return true;
  }

  static void listenForConnectionChanges(BuildContext context, String phoneNumber) {
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> connectionStatus) async {
      if (connectionStatus.contains(ConnectivityResult.none)) {
        networkErrorShowSnackbar(context);
      }
    });
  }

  static void cancelConnectionSubscription() {
    _subscription?.cancel();
  }

  static void networkErrorShowSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No internet connection. Please check your settings.'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}







// class ConnectionChecker {
//   static StreamSubscription<List<ConnectivityResult>>? _subscription;

//   static checkConnection(BuildContext context) async {
//     List<ConnectivityResult> connectionStatus =
//         await Connectivity().checkConnectivity();
//     if (connectionStatus.contains(ConnectivityResult.none)) {
//       networkErrorShowSnackbar(context);
//     }
//   }

//   static void listenForConnectionChanges(BuildContext context) {
//     _subscription = Connectivity()
//         .onConnectivityChanged
//         .listen((List<ConnectivityResult> connectionStatus) {
//       if (connectionStatus.contains(ConnectivityResult.none)) {
//         networkErrorShowSnackbar(context);
//       } else {
//         // call the method that you want for fetch data
//         final otpService = OtpService();
//         await otpService.sendOtp(phoneNumber, context);
       
//       }
//     });
//   }

//   static void cancelConnectionSubscription() {
//     _subscription?.cancel();
//   }

//   static void networkErrorShowSnackbar(BuildContext context) {
//     // Check if context is not null
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('No internet connection. Please check your settings.'),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }