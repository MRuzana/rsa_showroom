import 'package:geolocator/geolocator.dart';


class LocationService {
  String? _jwtToken;
  String? providerId;

  // Future<void> _loadToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _jwtToken = prefs.getString('jwtToken');
  //   providerId = prefs.getString('providerId');
  // }

  Stream<Position>? _positionStream;

  void startListening(Function(Position) onUpdate) {
    LocationSettings settings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _positionStream = Geolocator.getPositionStream(locationSettings: settings);
    _positionStream!.listen(onUpdate);
  }

  // Future<void> sendcurrentLocationToAPI(double lat, double log) async {

  //   if (_jwtToken == null) {
  //     await _loadToken(); // Ensure token is loaded before making request
  //   }

  //   final String apiUrl =
  //       '${ApiConstants.kBaseUrl}${EndPoints.provider}/$providerId';

  //   try {
  //     final response = await http.put(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer $_jwtToken',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'currentLocation': '$lat, $log',
  //         // 'currentLocation': {
  //         //   'latitude': lat,
  //         //   'longitude': log,
  //         // },
  //         // 'timestamp': DateTime.now().toIso8601String(), // Optional
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       print("Location updated successfully.");
  //     } else {
  //       print("Failed to update location: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("🚫 Error sending location: $e");
  //   }
  // }
}












// class LocationService {

//    String? _jwtToken;
//    String? providerId;

//   Future<void> _loadToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     _jwtToken = prefs.getString('jwtToken');
//     providerId = prefs.getString('providerId');
//   }
//   Stream<Position>? _positionStream;

//   void startListening(Function(Position) onUpdate) {
//     LocationSettings settings = const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 10,
//     );

//     _positionStream = Geolocator.getPositionStream(locationSettings: settings);
//     _positionStream!.listen(onUpdate);
//   }

// Future<void> sendcurrentLocationToAPI(double lat, double log) async {

//    if (_jwtToken == null) {
//       await _loadToken(); // Ensure token is loaded before making request
//     }
//   // final prefs = await SharedPreferences.getInstance();
//   // final providerId = prefs.getString('providerId');

//   final String apiUrl = '${ApiConstants.kBaseUrl}${EndPoints.provider}/$providerId';

//   try {
//     final response = await http.put(
//       Uri.parse(apiUrl),
//       headers: {
//         'Authorization': 'Bearer $_jwtToken',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'currentLocation': '$lat, $log',
//         // 'currentLocation': {
//         //   'latitude': lat,
//         //   'longitude': log,
//         // },
//         // 'timestamp': DateTime.now().toIso8601String(), // Optional
//       }),
//     );

//     if (response.statusCode == 200) {
//       print("Location updated successfully.");
//     } else {
//       print("Failed to update location: ${response.body}");
//     }
//   } catch (e) {
//     print("🚫 Error sending location: $e");
//   }
// }

// }
