import 'package:bus_pos/core/services/http_client.dart';
import 'package:bus_pos/core/errors/exceptions.dart';

class PaymentsApi {
  final HttpClient _client = HttpClient();

  // GET /payments/customer-payments/fetch-customer-payment-details-by-transaction-dils/{payment_id}/{transaction_id}
  Future<dynamic> fetchCustomerPaymentDetailsByTransaction({
    required String paymentId,
    required String transactionId,
  }) async {
    final url =
        '/payments/customer-payments/fetch-customer-payment-details-by-transaction-dils/$paymentId/$transactionId';
    try {
      final res = await _client.get(url);
      return res;
    } catch (e) {
      throw ApiException(
        message: 'Failed to fetch customer payment details by transaction: $e',
      );
    }
  }

  // GET /payments/customer-payments/confirm-customer-payment-details-by-transaction-dils/{payment_id}/{transaction_id}
  Future<dynamic> confirmCustomerPaymentDetailsByTransaction({
    required String paymentId,
    required String transactionId,
  }) async {
    final url =
        '/payments/customer-payments/confirm-customer-payment-details-by-transaction-dils/$paymentId/$transactionId';
    try {
      final res = await _client.get(url);
      return res;
    } catch (e) {
      throw ApiException(
        message:
            'Failed to confirm customer payment details by transaction: $e',
      );
    }
  }
}
