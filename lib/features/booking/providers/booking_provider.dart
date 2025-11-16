import 'package:bus_pos/features/booking/data/booking_repository.dart';
import 'package:bus_pos/features/booking/models/bus.dart';
import 'package:bus_pos/features/booking/models/enum.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _repository = BookingRepository();

  bool _isLoading = false;
  Bus? _selectedBus;

  Bus? get selectedBus => _selectedBus;

  bool get isLoading => _isLoading;

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
}
