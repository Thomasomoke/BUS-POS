import 'package:flutter/material.dart';

class SummarySection extends StatelessWidget {
  final int totalBookings;
  final int totalPayments;
  final int totalParcels;

  const SummarySection({
    super.key,
    required this.totalBookings,
    required this.totalPayments,
    required this.totalParcels,
  });

  @override
  Widget build(BuildContext context) {
    Widget summaryCard(String title, String value) => Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Summary",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final String title = index == 0
                  ? 'Total Bookings'
                  : index == 1
                  ? "Total Payments "
                  : "Total Parcels";
              final String value = index == 0
                  ? "$totalBookings"
                  : index == 1
                  ? 'KSh $totalPayments'
                  : "$totalParcels";

              return summaryCard(title, value);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 4.0),
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
