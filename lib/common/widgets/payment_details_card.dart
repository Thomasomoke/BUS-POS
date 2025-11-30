import 'package:flutter/material.dart';
import 'package:bus_pos/common/widgets/app_card.dart';
import 'package:bus_pos/features/payments/models/payment_details.dart';

class PaymentDetailsCard extends StatelessWidget {
  final PaymentDetails paymentDetails;

  const PaymentDetailsCard({Key? key, required this.paymentDetails})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      // ← Using your common AppCard instead of Card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Passenger Customer Payment Details',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('PAYMENT METHOD:', 'M-PESA'),
            _buildDetailRow('CURRENCY:', paymentDetails.currency),
            _buildDetailRow('AMOUNT:', 'KES ${paymentDetails.amount}'),
            _buildDetailRow(
              'PAYMENT PHONE NUMBER:',
              paymentDetails.phoneNumber,
            ),
            if (paymentDetails.businessNumber.isNotEmpty)
              _buildDetailRow(
                'BUSINESS NUMBER:',
                paymentDetails.businessNumber,
              ),
            if (paymentDetails.accountNumber.isNotEmpty)
              _buildDetailRow('ACCOUNT NUMBER:', paymentDetails.accountNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
