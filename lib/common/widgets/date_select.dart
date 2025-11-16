import 'package:bus_pos/core/utils/date_picker.dart';
import 'package:flutter/material.dart';

class DateSelect extends StatelessWidget {
  final bool isEnabled;
  final String placeholder;
  final void Function(DateTime selectedDate) setDate;
  const DateSelect({
    super.key,
    this.isEnabled = true,
    required this.placeholder,
    required this.setDate,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.6,
      child: GestureDetector(
        onTap: !isEnabled
            ? null
            : () async {
                final date = await pickDate(context);
                setDate(date);
              },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: isEnabled
                  ? Theme.of(context).primaryColor.withAlpha(200)
                  : Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: Text(
            placeholder,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: isEnabled ? Colors.black : Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
