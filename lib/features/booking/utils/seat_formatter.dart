import 'package:bus_pos/features/booking/models/seat_booking_model.dart';

List<Seat?> prepareGridData(int maxSeatsPerRow, List<Seat> seats) {
  final Map<int, List<Seat>> rowMap = {};
  List<Seat?> gridData = [];

  for (var seat in seats) {
    rowMap.putIfAbsent(seat.row, () => []).add(seat);
  }


  final sortedRows = rowMap.keys.toList()..sort();

  for (var rowNum in sortedRows) {
    final rowSeats = rowMap[rowNum]!;
    rowSeats.sort((a, b) => a.position.compareTo(b.position));

    final emptySlots = maxSeatsPerRow - rowSeats.length;
    final leftPadding = emptySlots ~/ 2;
    final rightPadding = emptySlots - leftPadding;

    for (int i = 0; i < leftPadding; i++) {
      gridData.add(null);
    }

    for (var seat in rowSeats) {
      gridData.add(seat);
    }

    for (int i = 0; i < rightPadding; i++) {
      gridData.add(null);
    }
  }
  return gridData;
}

int getMaxSeatsPerRow(List<Seat> seats) {
  final Map<int, int> rowCounts = {};
  for (var seat in seats) {
    rowCounts[seat.row] = (rowCounts[seat.row] ?? 0) + 1;
  }
  return rowCounts.values.isEmpty
      ? 3
      : rowCounts.values.reduce((a, b) => a > b ? a : b);
}
