import 'package:bus_pos/common/widgets/app_button.dart';
import 'package:bus_pos/common/widgets/date_select.dart';
import 'package:bus_pos/common/widgets/select_input.dart';
import 'package:bus_pos/core/utils/formatter.dart';
import 'package:bus_pos/features/booking/data/dummy_data.dart';
import 'package:bus_pos/features/booking/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DestinationAndDatePicker extends StatefulWidget {
  const DestinationAndDatePicker({super.key});

  @override
  State<DestinationAndDatePicker> createState() =>
      _DestinationAndDatePickerState();
}

class _DestinationAndDatePickerState extends State<DestinationAndDatePicker> {
  String departure = "";
  String destination = "";
  DateTime travelDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Expanded(
              child: Column(
                spacing: 12.0,
                children: [
                  SelectInput(
                    placeholder: departure.isEmpty
                        ? "Departure From"
                        : departure,
                    items: locations,
                    onSelect: (value) {
                      setState(() {
                        departure = value;
                      });
                    },
                  ),
                  SelectInput(
                    placeholder: destination.isEmpty
                        ? "Destination"
                        : destination,
                    items: locations.where((loc) => loc != departure).toList(),
                    isEnabled: departure.isEmpty ? false : true,
                    onSelect: (value) {
                      setState(() {
                        destination = value;
                      });
                    },
                  ),
                  DateSelect(
                    placeholder:
                        "Travel Date: ${destination.isEmpty ? "" : formatDate(travelDate)}",
                    setDate: (selectedDate) {
                      setState(() {
                        travelDate = selectedDate;
                      });
                    },
                    isEnabled: destination.isEmpty ? false : true,
                  ),
                ],
              ),
            ),
            if (destination.isNotEmpty && departure.isNotEmpty)
              AppButton(onPressed: provider.captureData, text: "Continue"),
          ],
        );
      },
    );
  }
}
