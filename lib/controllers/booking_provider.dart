import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rsa_showroom/models/booking_model.dart';
import 'package:rsa_showroom/services/booking_services.dart';

// with pagination


class BookingListProvider extends ChangeNotifier {
  List<BookingModel> _bookings = [];
  List<BookingModel> get bookings => _bookings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _page = 1;
  final int _limit = 10;
  int _totalPages = 1;

  final BookingService _bookingService = BookingService();

  bool get hasMore => _page < _totalPages;

  BookingListProvider() {
    fetchBookings(reset: true);
  }

  Future<void> fetchBookings({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _isLoading = true;
      _bookings = [];
    } else {
      if (!hasMore) return;
      _isLoadingMore = true;
      _page++; // move to next page
    }

    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _bookingService.fetchShowroomStaffBooking(
        _page,
        _limit,
      );

      _totalPages = response['totalPages'];
      final List<BookingModel> fetchedBookings = response['bookings'];

      if (reset) {
        _bookings = fetchedBookings;
      } else {
        _bookings.addAll(fetchedBookings);
      }
    } catch (error) {
      _errorMessage = 'Failed to fetch bookings';
      if (reset) _bookings = [];
    } finally {
      _isLoading = false;
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreBookings() async {
    if (_isLoadingMore || !hasMore) return;
    await fetchBookings();
  }
}
