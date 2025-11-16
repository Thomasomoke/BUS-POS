import 'package:bus_pos/common/widgets/app_button.dart';
import 'package:bus_pos/features/booking/utils/seat_formatter.dart';
import 'package:bus_pos/features/booking/models/enum.dart';
import 'package:bus_pos/features/booking/models/seat_booking_model.dart';
import 'package:bus_pos/features/booking/presentation/components/seat_status_guide.dart';
import 'package:bus_pos/features/booking/presentation/components/seat_widget.dart';
import 'package:bus_pos/features/booking/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatSelection extends StatefulWidget {
  const SeatSelection({super.key});

  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  late List<Seat> seats;

  @override
  void initState() {
    super.initState();
    seats = List.from(
      Provider.of<BookingProvider>(context, listen: false).selectedBus?.seats ??
          [],
    );
  }

  void _toggleSeat(String seatId) {
    setState(() {
      final index = seats.indexWhere((seat) => seat.id == seatId);
      if (index != -1 && seats[index].status == SeatStatus.available) {
        seats[index] = seats[index].copyWith(status: SeatStatus.selected);
      } else if (index != -1 && seats[index].status == SeatStatus.selected) {
        seats[index] = seats[index].copyWith(status: SeatStatus.available);
      }
    });
  }

  List<Seat?> _gridData = [];

  @override
  Widget build(BuildContext context) {
    final selectedCount = seats
        .where((s) => s.status == SeatStatus.selected)
        .length;
    int maxSeatsPerRow = getMaxSeatsPerRow(seats);
    _gridData = prepareGridData(maxSeatsPerRow, seats);

    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        return Column(
          spacing: 12.0,
          children: [
            Text(
              "Select Seats ($selectedCount Selected)",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SeatStatusGuide(),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: maxSeatsPerRow,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _gridData.length,
                itemBuilder: (context, index) {
                  final seat = _gridData[index];
                  if (seat == null) {
                    return const SizedBox.shrink();
                  }
                  return SeatWidget(
                    seat: seat,
                    toggleSeat: (seatId) => _toggleSeat(seatId),
                  );
                },
              ),
            ),
            if (selectedCount > 0)
              AppButton(
                onPressed: provider.captureData,
                text:
                    "Pay Ksh ${selectedCount * Provider.of<BookingProvider>(context, listen: false).selectedBus!.fare}",
              ),
          ],
        );
      },
    );
  }
}
