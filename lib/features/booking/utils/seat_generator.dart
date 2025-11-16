import 'package:bus_pos/features/booking/models/enum.dart';
import 'package:bus_pos/features/booking/models/seat_booking_model.dart';

class SeatGenerator {
  static List<Seat> generateSeats(int total, List<int> bookedSeats) {
    List<Seat> seats = [];
    int seatNumber = 1;

    List<int> rowPattern = _getRowPattern(total);

    if (total > 35) {
      seats.addAll([
        Seat(id: '', status: SeatStatus.booked, row: 1, position: 0),
        Seat(id: '', status: SeatStatus.booked, row: 1, position: 1),
        Seat(id: 'Driver', status: SeatStatus.booked, row: 1, position: 3),
      ]);
    }

    for (int rowIndex = 0; rowIndex < rowPattern.length; rowIndex++) {
      int seatsInRow = rowPattern[rowIndex];

      int row = total > 35 ? rowIndex + 2 : rowIndex + 1;

      for (int pos = 0; pos < seatsInRow; pos++) {
        if (seatNumber <= total) {
          if (total <= 35 && row == 1 && pos == 2) {
            seats.add(
              Seat(
                id: 'Driver',
                status: SeatStatus.booked,
                row: row,
                position: pos,
              ),
            );
          } else {
            seats.add(
              Seat(
                id: seatNumber.toString(),
                status: bookedSeats.contains(seatNumber)
                    ? SeatStatus.booked
                    : SeatStatus.available,
                row: row,
                position: pos,
              ),
            );
          }
          seatNumber++;
        }
      }
    }
    return seats;
  }

  static List<int> _getRowPattern(int totalSeats) {
    // For large buses (>35 seats), use 4 seats per row for all passenger rows
    if (totalSeats > 35) {
      int fullRows = totalSeats ~/ 4;
      int remainingSeats = totalSeats % 4;
      List<int> pattern = List.filled(fullRows, 4);
      if (remainingSeats > 0) {
        pattern.add(remainingSeats);
      }
      return pattern;
    }

    if (totalSeats <= 14) {
      return List.filled((totalSeats / 3).ceil(), 3);
    } else if (totalSeats <= 24) {
      List<int> pattern = [3];
      int remaining = totalSeats - 3;
      pattern.addAll(List.filled((remaining / 4).ceil(), 4));
      return pattern;
    } else {
      List<int> pattern = [3];
      int remaining = totalSeats - 3;

      int fourSeatRows = remaining ~/ 4;
      pattern.addAll(List.filled(fourSeatRows, 4));

      int lastRowSeats = remaining % 4;
      if (lastRowSeats > 0) {
        pattern.add(lastRowSeats);
      }

      return pattern;
    }
  }

  static List<Seat> generateSeatsWithPattern(
    int total,
    List<int> bookedSeats,
    List<int> customPattern,
  ) {
    List<Seat> seats = [];
    int seatNumber = 1;

    if (total > 35) {
      seats.addAll([
        Seat(id: 'Empty_L', status: SeatStatus.booked, row: 1, position: 0),
        Seat(id: 'Driver', status: SeatStatus.booked, row: 1, position: 1),
        Seat(id: 'Empty_R', status: SeatStatus.booked, row: 1, position: 2),
      ]);
    }

    for (int rowIndex = 0; rowIndex < customPattern.length; rowIndex++) {
      int seatsInRow = customPattern[rowIndex];

      int row = total > 35 ? rowIndex + 2 : rowIndex + 1;

      for (int pos = 0; pos < seatsInRow; pos++) {
        if (seatNumber <= total) {
          if (total <= 35 && row == 1 && pos == 2) {
            seats.add(
              Seat(
                id: 'Driver',
                status: SeatStatus.booked,
                row: row,
                position: pos,
              ),
            );
          } else {
            seats.add(
              Seat(
                id: seatNumber.toString(),
                status: bookedSeats.contains(seatNumber)
                    ? SeatStatus.booked
                    : SeatStatus.available,
                row: row,
                position: pos,
              ),
            );
          }
          seatNumber++;
        }
      }
    }
    return seats;
  }

  static int getMaxSeatsInRow(List<int> pattern) {
    if (pattern.isEmpty) return 3;
    return pattern.reduce((a, b) => a > b ? a : b);
  }
}
