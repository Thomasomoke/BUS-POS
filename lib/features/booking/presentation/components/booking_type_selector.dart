import 'package:bus_pos/core/config/extensions.dart';
import 'package:bus_pos/features/booking/models/enum.dart';
import 'package:bus_pos/features/booking/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingTypeSelector extends StatelessWidget {
  const BookingTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context,provider,child) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: [
              Text(
                "Select Booking type",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4.0),
              ...BookingType.values.map(
                (value) => ListTile(
                  title: Text(
                    "${value.name.toSentenceCase()} Booking",
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(color: Colors.white),
                  ),
        
                  tileColor: Theme.of(context).primaryColor.withAlpha(200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8.0),
                  ),
                  onTap: () => provider.setBookingType(value),
                ),
              ),
            ],
          );
      }
    );
  }
}