import 'package:dio/dio.dart';
import 'package:rsa_showroom/api/api_constants.dart';
import 'package:rsa_showroom/api/endpoints.dart';
import 'package:rsa_showroom/models/showroon_staff_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowroomStaffSevices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.kBaseUrl,
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  ShowroomStaffSevices() {
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

  /// ✅ staffId taken from SharedPreferences
  Future<ShowroomStaffModel> fetchStaffDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final staffId = prefs.getString('staffId');

      if (staffId == null || staffId.isEmpty) {
        throw Exception('Staff ID not found in local storage');
      }

      final response = await _dio.get(
        '${EndPoints.fetchStaffDetails}/$staffId',
      );

      if (response.statusCode == 200) {
        return ShowroomStaffModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load staff');
      }
    } catch (e) {
      print("Error fetching staff details: $e");
      throw Exception('Failed to load staff details');
    }
  }
}