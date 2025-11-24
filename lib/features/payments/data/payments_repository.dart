import 'package:bus_pos/features/payments/data/payments_api.dart';
import 'package:bus_pos/features/payments/models/payment_details.dart';
import 'package:bus_pos/features/payments/models/payment_confirmation.dart';
import 'package:bus_pos/core/errors/exceptions.dart';

class PaymentsRepository {
  final PaymentsApi _api = PaymentsApi();

  Future<PaymentDetails> fetchCustomerPaymentDetailsByTransaction({
    required String paymentId,
    required String transactionId,
  }) async {
    try {
      final raw = await _api.fetchCustomerPaymentDetailsByTransaction(
        paymentId: paymentId,
        transactionId: transactionId,
      );
      if (raw is Map<String, dynamic>) return PaymentDetails.fromJson(raw);
      return PaymentDetails.fromJson(Map<String, dynamic>.from(raw));
    } catch (e) {
      throw ApiException(
        message: 'Failed to fetch customer payment details by transaction: $e',
      );
    }
  }

  Future<PaymentConfirmation> confirmCustomerPaymentDetailsByTransaction({
    required String paymentId,
    required String transactionId,
  }) async {
    try {
      final raw = await _api.confirmCustomerPaymentDetailsByTransaction(
        paymentId: paymentId,
        transactionId: transactionId,
      );
      if (raw is Map<String, dynamic>) return PaymentConfirmation.fromJson(raw);
      return PaymentConfirmation.fromJson(Map<String, dynamic>.from(raw));
    } catch (e) {
      throw ApiException(
        message:
            'Failed to confirm customer payment details by transaction: $e',
      );
    }
  }
}
