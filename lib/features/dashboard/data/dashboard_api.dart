import 'package:bus_pos/core/services/http_client.dart';
import 'package:bus_pos/core/errors/exceptions.dart';

class DashboardApi {
  final HttpClient _client = HttpClient();

  // GET /transactions/passenger-bookings/get-operator-passenger-bookings/{operator_id}
  Future<List<dynamic>> getPassengerBookings(String operatorId) async {
    final url =
        '/transactions/passenger-bookings/get-operator-passenger-bookings/$operatorId';
    try {
      final res = await _client.get(
        url,
      ); // expect a Map or List depending on HttpClient
      // The API might return { "message": "bookings", "data": [ ... ] } or simply a list.
      final data = res as Map;
      if (data.containsKey('data')) {
        return (data['data'] as List).cast<dynamic>();
      }
      if (res is List) return (res as List).cast<dynamic>();
      throw ApiException(message: 'Unexpected passenger bookings response');
    } catch (e) {
      throw ApiException(message: 'Failed to fetch passenger bookings: $e');
    }
  }

  // GET /transactions/percel-bookings/get-operator-passenger-bookings/{operator_id}
  Future<List<dynamic>> getParcelBookings(String operatorId) async {
    final url =
        '/transactions/percel-bookings/get-operator-passenger-bookings/$operatorId';
    try {
      final res = await _client.get(url);
      final data = res as Map;
      if (data.containsKey('data')) {
        return (data['data'] as List).cast<dynamic>();
      }
      if (res is List) return (res as List).cast<dynamic>();
      throw ApiException(message: 'Unexpected parcel bookings response');
    } catch (e) {
      throw ApiException(message: 'Failed to fetch parcel bookings: $e');
    }
  }

  // GET /payments/operator-payments/count-all-operator-payments
  Future<Map<String, dynamic>> countAllOperatorPayments() async {
    final url = '/payments/operator-payments/count-all-operator-payments';
    try {
      final res = await _client.get(url);
      if (res is Map) return (res as Map<dynamic, dynamic>).cast<String, dynamic>();
      throw ApiException(message: 'Unexpected payments count response');
    } catch (e) {
      throw ApiException(message: 'Failed to fetch payments count: $e');
    }
  }
}
