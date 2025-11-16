import 'package:flutter/material.dart';

class SeatStatusGuide extends StatelessWidget {
  const SeatStatusGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem('Available', Colors.white, Colors.black),
        _buildLegendItem(
          'Selected',
          Theme.of(context).primaryColor.withAlpha(200),
          Colors.white,
        ),
        _buildLegendItem('Booked', Colors.grey, Colors.white),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, Color textColor) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}