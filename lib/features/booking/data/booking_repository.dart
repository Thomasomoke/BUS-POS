import 'package:bus_pos/features/booking/data/booking_api.dart';
import 'package:bus_pos/features/booking/models/bus.dart';
import 'package:bus_pos/features/booking/models/enum.dart';

class BookingRepository {
  final BookingApi _api = BookingApi();

  Future<Map<String, dynamic>> submitBooking({
    required Map<String, dynamic> passengerData,
    required BookingType bookingType,
    required Bus bus,
  }) async {
    if (bookingType == BookingType.seat) {
      return await _api.addPassengerBooking(passengerData);
    } else {
      return await _api.addParcelBooking(passengerData);
    }
  }
}
