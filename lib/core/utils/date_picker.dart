import 'package:flutter/material.dart';

Future<DateTime> pickDate(BuildContext context) async {
  final DateTime today = DateTime.now();
  final picked = await showDatePicker(
    context: context,
    firstDate: today,
    lastDate: DateTime(today.year + 1),
    initialDate: today,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
            confirmButtonStyle: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor.withAlpha(200),
              ),
              textStyle: WidgetStatePropertyAll(
                Theme.of(context).textTheme.labelMedium,
              ),
            ),
            cancelButtonStyle: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black38),
              textStyle: WidgetStatePropertyAll(
                Theme.of(context).textTheme.labelMedium,
              ),
            ),
            todayBackgroundColor: WidgetStatePropertyAll(Colors.blue.shade100),
            todayForegroundColor: WidgetStatePropertyAll(Colors.black),

            dayForegroundColor: WidgetStateProperty.resolveWith(
              (states) =>
                  states.contains(WidgetState.selected) ? Colors.white : null,
            ),
            dayBackgroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? Theme.of(context).primaryColor.withAlpha(200)
                  : null,
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  return picked!;
}
