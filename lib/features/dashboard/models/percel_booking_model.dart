class ParcelBookingModel {
  final String id;

  final String senderName;

  final String receiverName;

  final double price;

  final String status;

  final String createdAt;

  const ParcelBookingModel({
    required this.id,
    required this.senderName,
    required this.receiverName,
    required this.price,
    required this.status,
    required this.createdAt,
  });

  factory ParcelBookingModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return ParcelBookingModel(
      id: data['id'] as String,
      senderName: data['sender_name'] as String,
      receiverName: data['receiver_name'] as String,
      price: (data['price'] as num).toDouble(),
      status: data['status'] as String,
      createdAt: data['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': {
      'id': id,
      'sender_name': senderName,
      'receiver_name': receiverName,
      'price': price,
      'status': status,
      'created_at': createdAt,
    },
  };
}
