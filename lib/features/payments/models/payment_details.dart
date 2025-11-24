class PaymentDetails {
  final String id;
  final double amount;
  final String currency;
  final String phoneNumber;
  final String businessNumber;
  final String accountNumber;
  final String status;

  PaymentDetails({
    required this.id,
    required this.amount,
    required this.currency,
    required this.phoneNumber,
    required this.businessNumber,
    required this.accountNumber,
    required this.status,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      id: json['id']?.toString() ?? '',
      amount: json['amount'] != null
          ? double.tryParse(json['amount'].toString()) ?? 0.0
          : 0.0,
      currency: json['currency']?.toString() ?? 'KES',
      phoneNumber:
          json['phoneNumber']?.toString() ??
          json['phone_number']?.toString() ??
          '',
      businessNumber:
          json['businessNumber']?.toString() ??
          json['business_number']?.toString() ??
          '',
      accountNumber:
          json['accountNumber']?.toString() ??
          json['account_number']?.toString() ??
          '',
      status: json['status']?.toString() ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'currency': currency,
      'phoneNumber': phoneNumber,
      'businessNumber': businessNumber,
      'accountNumber': accountNumber,
      'status': status,
    };
  }

  // Helper methods for common status checks
  bool get isCompleted => status.toLowerCase() == 'completed';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isFailed => status.toLowerCase() == 'failed';
}
