import 'package:bus_pos/features/booking/models/bus.dart';
import 'package:bus_pos/features/booking/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class BusCard extends StatelessWidget {
  final Bus bus;
  const BusCard({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor.withAlpha(200);
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: provider.isLoading ? null : () => provider.setSelectedBus(bus),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: color),
            ),
            child: Row(
              spacing: 8.0,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 3,
                    children: [
                      Icon(FontAwesome.bus_solid, size: 26),
                      Text(
                        bus.busOperator,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: color,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${bus.from} To ${bus.to}",
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${bus.travelDate.year}-${bus.travelDate.month.toString().padLeft(2, '0')}-${bus.travelDate.day.toString().padLeft(2, '0')} [${bus.time}]',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Seats Available',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.event_seat,
                                      size: 14,
                                      color: color,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${bus.seatsAvailable} Seat(s) left',
                                      style: TextStyle(color: color),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'Fare Amount',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'KES ${bus.fare.toInt()}',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(color: color),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
