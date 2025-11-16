class PaymentsCountModel {
  final int count;

  final String? status;

  final String? message;

  const PaymentsCountModel({required this.count, this.status, this.message});

  factory PaymentsCountModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    return PaymentsCountModel(
      count: data != null ? (data['count'] as int? ?? 0) : 0,
      status: json['status']?.toString(),
      message: json['message']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': {'count': count},
    'status': status,
    'message': message,
  };
}
