import 'package:dio/dio.dart';
import 'package:rsa_showroom/api/api_constants.dart';
import 'package:rsa_showroom/api/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.kBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      validateStatus: (status) => status != null && status < 500,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<bool> sendSignUpDetails({
    required String name,
    required String phone,
    required String designation,
    required String whatsappNumber,
    required String showroomId,
  }) async {
    try {
      final response = await _dio.post(
        EndPoints.staffSignUp,
        data: {
          "name": name,
          "phone": phone,
          "designation": designation,
          "whatsappNumber": whatsappNumber,
          "showroomId": showroomId,
        },
      );

      // ✅ CHECK STATUS CODE
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Signup success');
        return true;
      }

      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        final status = e.response!.statusCode;
        final message = e.response!.data['message'];

        if (status == 400 && message == 'User already exists') {
          print('User already exists');
          return false;
        }
      }

      print('Signup failed');
      return false;
    }
  }

  Future<bool> sendLoginDetails({
    required String phoneNumber,
    required String showroomId,
  }) async {
    try {
      final response = await _dio.post(
        EndPoints.staffSignin,
        data: {
          "phoneNumber": phoneNumber,
          "showroom": showroomId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {
          final prefs = await SharedPreferences.getInstance();

          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('token', data['token']);
          await prefs.setString('role', data['role']);
          await prefs.setString('name', data['name']);
          await prefs.setString('phoneNumber', phoneNumber);
          await prefs.setString('showroomId', showroomId);

          print('showroom token: ${data['token']}');

          print('Login success & data saved');
          return true;
        }
      }

      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      }
      return false;
    }
  }
}
