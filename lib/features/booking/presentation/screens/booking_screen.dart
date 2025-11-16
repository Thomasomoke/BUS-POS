import 'package:bus_pos/features/booking/models/enum.dart';
import 'package:bus_pos/features/booking/presentation/components/booking_type_selector.dart';
import 'package:bus_pos/features/booking/presentation/components/destination_and_date_picker.dart';
import 'package:bus_pos/features/booking/presentation/components/seat_selection.dart';
import 'package:bus_pos/features/booking/presentation/components/user_details.dart';
import 'package:bus_pos/features/booking/presentation/components/vehicle_selector.dart';
import 'package:bus_pos/features/booking/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  Widget getCurrentWidget(int step, BookingType type) {
    switch (step) {
      case 0:
        return BookingTypeSelector();
      case 1:
        return DestinationAndDatePicker();
      case 2:
        return VehicleSelector();

      case 3:
        switch (type) {
          case BookingType.seat:
            return SeatSelection();
          case BookingType.parcel:
            return Center(child: Text("Parcel Information"));
        }
      case 4:
        return UserDetails();
      default:
        return Center(child: Text("Default Return"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          width: double.infinity,
          child: Column(
            spacing: 4.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (provider.currentStep > 0)
                BackButton(onPressed: () => provider.goBack()),
              Expanded(
                child: getCurrentWidget(
                  provider.currentStep,
                  provider.bookingType,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
