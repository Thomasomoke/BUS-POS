import 'package:bus_pos/features/booking/models/seat_booking_model.dart';

class Bus {
  final String id;
  final String busOperator;
  final String? operatorLogo;
  final String from;
  final String to;
  final DateTime travelDate;
  final String time;
  final int seatsAvailable;
  final int totalSeats;
  final double fare;
  final List<Seat> seats;

  Bus({
    required this.id,
    required this.busOperator,
    this.operatorLogo,
    required this.from,
    required this.to,
    required this.travelDate,
    required this.time,
    required this.seatsAvailable,
    required this.totalSeats,
    required this.fare,
    required this.seats,
  });
}
