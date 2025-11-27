import 'package:bus_pos/core/services/http_client.dart';
import 'package:bus_pos/core/errors/exceptions.dart';

class BookingApi {
  final HttpClient _client = HttpClient();

  Future<Map<String, dynamic>> addPassengerBooking(
    Map<String, dynamic> bookingData,
  ) async {
    final url = '/transactions/passenger-bookings/add-passenger-booking';
    try {
      final res = await _client.post(url, body: bookingData);
      if (res is Map)
        return (res as Map<dynamic, dynamic>).cast<String, dynamic>();
      throw ApiException(message: 'Unexpected passenger booking response');
    } catch (e) {
      throw ApiException(message: 'Failed to create passenger booking: $e');
    }
  }

  Future<Map<String, dynamic>> addParcelBooking(
    Map<String, dynamic> bookingData,
  ) async {
    final url = '/transactions/parcel-bookings/add-parcel-booking';
    try {
      final res = await _client.post(url, body: bookingData);
      if (res is Map)
        return (res as Map<dynamic, dynamic>).cast<String, dynamic>();
      throw ApiException(message: 'Unexpected parcel booking response');
    } catch (e) {
      throw ApiException(message: 'Failed to create parcel booking: $e');
    }
  }
}
