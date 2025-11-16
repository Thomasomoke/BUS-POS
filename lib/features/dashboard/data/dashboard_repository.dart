import 'package:bus_pos/features/dashboard/data/dashboard_api.dart';
import 'package:bus_pos/features/dashboard/models/booking_model.dart';
import 'package:bus_pos/features/dashboard/models/payments_count_model.dart';
import 'package:bus_pos/core/errors/exceptions.dart';
import 'package:bus_pos/features/dashboard/models/percel_booking_model.dart';

class DashboardRepository {
  final DashboardApi _api = DashboardApi();

  Future<List<BookingModel>> fetchPassengerBookings(String operatorId) async {
    try {
      final raw = await _api.getPassengerBookings(operatorId);
      return raw.map<BookingModel>((e) {
        if (e is Map<String, dynamic>) return BookingModel.fromJson(e);
        return BookingModel.fromJson(Map<String, dynamic>.from(e));
      }).toList();
    } catch (e) {
      throw ApiException(
        message: 'Failed to fetch operator passenger bookings: $e',
      );
    }
  }

  Future<List<ParcelBookingModel>> fetchParcelBookings(
    String operatorId,
  ) async {
    try {
      final raw = await _api.getParcelBookings(operatorId);
      return raw.map<ParcelBookingModel>((e) {
        if (e is Map<String, dynamic>) return ParcelBookingModel.fromJson(e);
        return ParcelBookingModel.fromJson(Map<String, dynamic>.from(e));
      }).toList();
    } catch (e) {
      throw ApiException(
        message: 'Failed to fetch  operator parcel bookings: $e',
      );
    }
  }

  Future<PaymentsCountModel> fetchPaymentsCount() async {
    try {
      final raw = await _api.countAllOperatorPayments();
      return PaymentsCountModel.fromJson(raw);
    } catch (e) {
      throw ApiException(message: 'Failed to fetch payments count: $e');
    }
  }
}
