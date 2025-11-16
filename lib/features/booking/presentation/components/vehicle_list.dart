import 'package:bus_pos/features/booking/models/bus.dart';
import 'package:bus_pos/features/booking/presentation/components/bus_card.dart';
import 'package:flutter/material.dart';

class VehicleList extends StatelessWidget {
  final List<Bus> filteredBuses;
  const VehicleList({super.key, required this.filteredBuses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2.0),
      itemCount: filteredBuses.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: BusCard(bus: filteredBuses[index]),
      ),
    );
  }
}
