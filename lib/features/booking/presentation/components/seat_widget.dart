import 'package:bus_pos/features/booking/models/enum.dart';
import 'package:bus_pos/features/booking/models/seat_booking_model.dart';
import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final Seat seat;
  final void Function(String seatId) toggleSeat;

  const SeatWidget({super.key, required this.seat, required this.toggleSeat});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    bool isClickable = false;

    switch (seat.status) {
      case SeatStatus.available:
        backgroundColor = Colors.white;
        textColor = Colors.black;
        isClickable = true;
        break;
      case SeatStatus.selected:
        backgroundColor = Theme.of(context).primaryColor.withAlpha(200);
        textColor = Colors.white;
        isClickable = true;
        break;
      case SeatStatus.booked:
        backgroundColor = Colors.grey;
        textColor = Colors.white;
        break;
    }
    return GestureDetector(
      onTap: isClickable ? () => toggleSeat(seat.id) : null,
      child: Container(
        width: 70,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        alignment: Alignment.center,
        child: Text(
          seat.id,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
