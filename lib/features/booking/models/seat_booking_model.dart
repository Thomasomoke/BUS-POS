import 'package:bus_pos/features/booking/models/enum.dart';

class Seat {
  final String id;
  final SeatStatus status;
  final int row;
  final int position;
  final SeatAlignment alignment; 
  Seat({
    required this.id,
    required this.status,
    required this.row,
    required this.position,
    this.alignment = SeatAlignment.center,
  });

  Seat copyWith({SeatStatus? status}) {
    return Seat(
      id: id,
      status: status ?? this.status,
      row: row,
      position: position,
      alignment: alignment,
    );
  }
}
