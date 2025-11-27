import 'package:bus_pos/features/booking/data/booking_repository.dart';
import 'package:bus_pos/features/booking/models/bus.dart';
import 'package:bus_pos/features/booking/models/enum.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();

  bool _isLoading = false;
  Bus? _selectedBus;
  String? _paymentId;
  String? _transactionId;

  Bus? get selectedBus => _selectedBus;
  bool get isLoading => _isLoading;
  String? get paymentId => _paymentId;
  String? get transactionId => _transactionId;

  BookingType _bookingType = BookingType.seat;
  BookingType get bookingType => _bookingType;

  int _currentStep = 0;
  int get currentStep => _currentStep;

  void setBookingType(BookingType type) {
    _bookingType = type;
    _currentStep++;
    notifyListeners();
  }

  void setSelectedBus(Bus bus) {
    _selectedBus = bus;
    _currentStep++;
    notifyListeners();
  }

  void goBack() {
    _currentStep--;
    notifyListeners();
  }

  void captureData() {
    _currentStep++;
    notifyListeners();
  }

  // New method to submit booking and get payment details
  Future<Map<String, String>?> submitBooking(
    Map<String, dynamic> passengerData,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Call the repository to submit booking - FIXED: Use named parameters
      final response = await _repository.submitBooking(
        passengerData: passengerData,
        bookingType: _bookingType,
        bus: _selectedBus!,
      );

      _isLoading = false;
      notifyListeners();

      // Return payment details for navigation
      return {
        'paymentId':
            response['payment_id'] ??
            response['id'] ??
            'PAY_${DateTime.now().millisecondsSinceEpoch}',
        'transactionId':
            response['transaction_id'] ??
            'TXN_${DateTime.now().millisecondsSinceEpoch}',
      };
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void reset() {
    _currentStep = 0;
    _selectedBus = null;
    _paymentId = null;
    _transactionId = null;
    _bookingType = BookingType.seat;
    notifyListeners();
  }
}
