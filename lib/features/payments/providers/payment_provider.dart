import 'package:flutter/foundation.dart';
import 'package:bus_pos/features/payments/data/payments_repository.dart';
import 'package:bus_pos/features/payments/models/payment_details.dart';

class PaymentProvider with ChangeNotifier {
  final PaymentsRepository _repository;

  PaymentProvider({required PaymentsRepository repository})
    : _repository = repository;

  // State
  PaymentDetails? _paymentDetails;
  bool _isLoading = false;
  bool _paymentConfirmed = false;
  String _errorMessage = '';
  String? _transactionId; // For manual entry

  // Getters
  PaymentDetails? get paymentDetails => _paymentDetails;
  bool get isLoading => _isLoading;
  bool get paymentConfirmed => _paymentConfirmed;
  String get errorMessage => _errorMessage;
  String? get transactionId => _transactionId;

  // Load payment details
  Future<void> loadPaymentDetails({
    required String paymentId,
    required String transactionId,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _paymentDetails = await _repository
          .fetchCustomerPaymentDetailsByTransaction(
            paymentId: paymentId,
            transactionId: transactionId,
          );
    } catch (e) {
      _errorMessage = 'Failed to load payment details: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Confirm payment
  Future<void> confirmPayment({
    required String paymentId,
    required String transactionId,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final confirmation = await _repository
          .confirmCustomerPaymentDetailsByTransaction(
            paymentId: paymentId,
            transactionId: transactionId,
          );

      if (confirmation.success) {
        _paymentConfirmed = true;
      } else {
        _errorMessage = confirmation.message;
      }
    } catch (e) {
      _errorMessage = 'Failed to confirm payment: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Set transaction ID for manual payment
  void setTransactionId(String id) {
    _transactionId = id;
    notifyListeners();
  }

  // Reset state
  void reset() {
    _paymentDetails = null;
    _paymentConfirmed = false;
    _errorMessage = '';
    _transactionId = null;
    notifyListeners();
  }
}
