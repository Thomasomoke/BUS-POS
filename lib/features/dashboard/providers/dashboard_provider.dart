import 'package:bus_pos/core/utils/toaster.dart';
import 'package:bus_pos/features/dashboard/models/payments_count_model.dart';
import 'package:bus_pos/features/dashboard/models/percel_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:bus_pos/features/dashboard/data/dashboard_repository.dart';
import 'package:bus_pos/features/dashboard/models/booking_model.dart';

class DashboardState {
  final List<BookingModel> bookings;
  final List<ParcelBookingModel> parcelBookings;
  final int paymentsCount;

  DashboardState({
    required this.bookings,
    required this.parcelBookings,
    required this.paymentsCount,
  });

  DashboardState.initial()
    : bookings = [],
      parcelBookings = [],
      paymentsCount = 0;
}

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _repository = DashboardRepository();

  DashboardState _state = DashboardState.initial();
  bool isLoading = false;
  String? error;

  DashboardState get state => _state;

  Future<void> loadAll(BuildContext context, String operatorId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final passengerFuture = _repository.fetchPassengerBookings(operatorId);
      final parcelFuture = _repository.fetchParcelBookings(operatorId);
      final paymentsFuture = _repository.fetchPaymentsCount();

      final results = await Future.wait([
        passengerFuture,
        parcelFuture,
        paymentsFuture,
      ]);

      final bookings = results[0] as List<BookingModel>;
      final parcels = results[1] as List<ParcelBookingModel>;
      final paymentsCount = results[2] as PaymentsCountModel;

      _state = DashboardState(
        bookings: bookings,
        parcelBookings: parcels,
        paymentsCount: paymentsCount.count,
      );
    } catch (e, st) {
      error = e.toString();
      debugPrint('DashboardProvider.loadAll error: $e\n$st');
      _state = DashboardState.initial();
      if (context.mounted) {
        showToast(context, isError: true, 'Error loading dashboard data: $e');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh(BuildContext context, operatorId) =>
      loadAll(context, operatorId);
}
