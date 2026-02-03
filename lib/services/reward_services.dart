import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rsa_showroom/api/api_constants.dart';
import 'package:rsa_showroom/api/endpoints.dart';
import 'package:rsa_showroom/models/reward_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.kBaseUrl,
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  RewardServices() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }

  Future<List<RewardModel>> fetchAllRewards() async {
    try {
      final response = await _dio.get(EndPoints.getReward);

      if (response.statusCode == 200) {
        final List rewardJson = response.data;
        return rewardJson.map((json) => RewardModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load rewards');
      }
    } catch (e) {
      log("Error fetching rewards: $e");
      throw Exception('Failed to load rewards');
    }
  }

  Future<bool> redeemReward({
    required String rewardId,
    //required String staffId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final staffId = prefs.getString('staffId');

      print('userId/staffId : $staffId');
      print('rewardId :$rewardId');

      final response = await _dio.get(
        EndPoints.redeemReward,
        queryParameters: {
          'userId': staffId,
          'rewardId': rewardId,
          'rewardFor': 'ShowroomStaff',
          // 'showroom': '694cc84328153b3d845b49ff'
        },
      );

      print("REDEEM STATUS: ${response.statusCode}");
      print("REDEEM RESPONSE: ${response.data}");

      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      print("REDEEM ERROR STATUS: ${e.response?.statusCode}");
      print("REDEEM ERROR DATA: ${e.response?.data}");
      return false;
    }
  }
}

  // Future<List<Map<String, String>>> fetchClaimedRewards(String driverId) async {
  //   if (_jwtToken == null) {
  //     await _loadToken(); // Ensure token is loaded before making request
  //   }
  //   final url =
  //       "${ApiConstants.kBaseUrl}${EndPoints.claimedRewards}?userType=Driver&userId=$driverId";
  //   try {
  //     // Make the GET request
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'Bearer $_jwtToken',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);

  //       // Check if the response contains the "data" field
  //       if (data['success'] == true && data['data'] != null) {
  //         // Map the data to a list of reward name, image, price, and description
  //         List<Map<String, String>> rewards = [];

  //         for (var item in data['data']) {
  //           var reward = item['reward']; // Get the reward details

  //           // Prepare the reward information
  //           Map<String, String> rewardData = {
  //             'name': reward['name'], // Extract name
  //             'image': reward['image'], // Extract image URL
  //             'price': reward['price'].toString(), // Extract price
  //             'description': reward['description'], // Extract description
  //           };

  //           // Check if the reward with the same name, price, and description already exists in the list
  //           bool isDuplicate = rewards.any((existingReward) =>
  //               existingReward['name'] == rewardData['name'] &&
  //               existingReward['price'] == rewardData['price'] &&
  //               existingReward['description'] == rewardData['description']);

  //           // If it's not a duplicate, add to the list
  //           if (!isDuplicate) {
  //             rewards.add(rewardData);
  //           }
  //         }

  //         return rewards;
  //       } else {
  //         // Return an empty list if there was no data or the response is unsuccessful
  //         return [];
  //       }
  //     } else {
  //       // Handle the case where the API response status is not 200
  //       throw Exception('Failed to load rewards');
  //     }
  //   } catch (error) {
  //     // Handle errors during the request
  //     print("Error fetching rewards: $error");
  //     throw Exception('Error fetching rewards');
  //   }
  // }

