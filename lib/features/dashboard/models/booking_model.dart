class BookingModel {
  final String id;

  final String passengerName;

  final String seat;

  final String route;

  final String travelDate;

  final double fare;

  final String status;

  const BookingModel({
    required this.id,
    required this.passengerName,
    required this.seat,
    required this.route,
    required this.travelDate,
    required this.fare,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return BookingModel(
      id: data['id'] as String,
      passengerName: data['passenger_name'] as String,
      seat: data['seat'] as String,
      route: data['route'] as String,
      travelDate: data['travel_date'] as String,
      fare: (data['fare'] as num).toDouble(),
      status: data['status'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': {
      'id': id,
      'passenger_name': passengerName,
      'seat': seat,
      'route': route,
      'travel_date': travelDate,
      'fare': fare,
      'status': status,
    },
  };
}
