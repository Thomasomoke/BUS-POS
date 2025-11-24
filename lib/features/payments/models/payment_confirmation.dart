class PaymentConfirmation {
  final bool success;
  final String message;
  final String transactionId;
  final String? bookingId;
  final DateTime confirmedAt;

  PaymentConfirmation({
    required this.success,
    required this.message,
    required this.transactionId,
    this.bookingId,
    required this.confirmedAt,
  });

  factory PaymentConfirmation.fromJson(Map<String, dynamic> json) {
    return PaymentConfirmation(
      success: json['success'] == true || json['status'] == 'success',
      message: json['message']?.toString() ?? 'Payment processed',
      transactionId:
          json['transactionId']?.toString() ??
          json['transaction_id']?.toString() ??
          '',
      bookingId:
          json['bookingId']?.toString() ?? json['booking_id']?.toString(),
      confirmedAt: json['confirmedAt'] != null
          ? DateTime.tryParse(json['confirmedAt'].toString()) ?? DateTime.now()
          : json['confirmed_at'] != null
          ? DateTime.tryParse(json['confirmed_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'transactionId': transactionId,
      'bookingId': bookingId,
      'confirmedAt': confirmedAt.toIso8601String(),
    };
  }
}
