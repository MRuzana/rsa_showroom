import 'package:dio/dio.dart';
import 'package:rsa_showroom/api/api_constants.dart';
import 'package:rsa_showroom/api/endpoints.dart';
import 'package:rsa_showroom/models/booking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.kBaseUrl,
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  BookingService() {
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

    Future<Map<String, dynamic>> fetchShowroomStaffBooking(
    int page,
    int limit,
  ) async {
    try {
      final response = await _dio.get(
        EndPoints.fetchBooking,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        final List bookingsJson = data['data']['bookings'];
        final pagination = data['data']['pagination'];

        List<BookingModel> bookings = bookingsJson
            .map((e) => BookingModel.fromJson(e))
            .toList();

        return {
          'bookings': bookings,
          'total': pagination['total'],
          'page': pagination['page'],
          'limit': pagination['limit'],
          'totalPages': pagination['totalPages'],
        };
      } else {
        throw Exception('Failed to load bookings');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      throw Exception('Failed to fetch bookings');
    }
  }

  Future<bool> addBooking({
    required String fileNumber,
    required String customerName,
    required String mob1,
    required String serviceCategory,
    required String customerVehicleNumber,
    required String comments,
    required String showroom,
  }) async {
    try {
      final response = await _dio.post(
        EndPoints.addBooking,
        data: {
          "fileNumber": fileNumber,
          "customerName": customerName,
          "mob1": mob1,
          "serviceCategory": serviceCategory,
          "customerVehicleNumber": customerVehicleNumber,
          "comments": comments,
          "showroom": showroom,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Booking added successfully');
        return true;
      }

      return false;
    } on DioException catch (e) {
      print("Add booking error: ${e.response?.data}");

      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE DATA: ${e.response?.data}");
      print("REQUEST DATA: ${e.requestOptions.data}");
      print("PATH: ${e.requestOptions.path}");

      throw Exception("Failed to add booking");
    }
  }
}
