import 'package:flutter/material.dart';
import 'package:bus_pos/common/widgets/app_button.dart';
import 'package:bus_pos/features/payments/models/payment_details.dart';

class PaymentOptionsSection extends StatefulWidget {
  final String paymentId;
  final String initialTransactionId;
  final PaymentDetails? paymentDetails;
  final bool isLoading;
  final Function(String) onConfirmPayment;

  const PaymentOptionsSection({
    Key? key,
    required this.paymentId,
    required this.initialTransactionId,
    required this.paymentDetails,
    required this.isLoading,
    required this.onConfirmPayment,
  }) : super(key: key);

  @override
  State<PaymentOptionsSection> createState() => _PaymentOptionsSectionState();
}

class _PaymentOptionsSectionState extends State<PaymentOptionsSection> {
  final TextEditingController _transactionIdController =
      TextEditingController();
  bool _showManualInstructions = false;

  @override
  void initState() {
    super.initState();
    _transactionIdController.text = widget.initialTransactionId;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Option 1: STKPush Notification
        _buildOption1(context),

        const SizedBox(height: 24),

        const Divider(),
        const SizedBox(height: 24),

        // Option 2: Manual Payment
        _buildOption2(context),

        const SizedBox(height: 32),

        // Confirm Payment Button
        _buildConfirmButton(context),
      ],
    );
  }

  Widget _buildOption1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Option 1: STKPush Notification',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          'Request customer to check his/her phone for the M-PESA pop-up and enter his/her PIN number. Once M-PESA message is received by the customer, click the "Confirm Payment" button below to finalize the transaction.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildOption2(BuildContext context) {
    final businessNumber = widget.paymentDetails?.businessNumber ?? '900566';
    final accountNumber = widget.paymentDetails?.accountNumber ?? '2FOMO/MOC';
    final amount = widget.paymentDetails?.amount ?? 1000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Option 2: Follow the below steps if the customer hasn\'t received the M-PESA pop-up to input his/her PIN:',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Toggle manual instructions
        TextButton(
          onPressed: () {
            setState(() {
              _showManualInstructions = !_showManualInstructions;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _showManualInstructions
                    ? 'Hide Manual Payment Instructions'
                    : 'Show Manual Payment Instructions',
              ),
              const SizedBox(width: 8),
              Icon(
                _showManualInstructions
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 20,
              ),
            ],
          ),
        ),

        if (_showManualInstructions) ...[
          const SizedBox(height: 16),
          _buildStep('1. Go to M-PESA menu option on your phone'),
          _buildStep('2. Select Lipa na M-PESA'),
          _buildStep('3. Select Pay Bill'),
          _buildStep('4. Enter $businessNumber as Business Number'),
          _buildStep('5. Enter $accountNumber as Account Number'),
          _buildStep('6. Enter $amount as Amount'),
          _buildStep('7. Input your PIN'),
          const SizedBox(height: 12),
          Text(
            'Upon receiving M-PESA SMS, enter the transaction code below and click "Confirm Payment".',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],

        const SizedBox(height: 16),

        // Transaction ID input
        TextField(
          controller: _transactionIdController,
          decoration: const InputDecoration(
            labelText: 'M-PESA Transaction Code',
            hintText: 'Enter transaction code from SMS (e.g., ABC123XYZ)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.receipt),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildStep(String step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(step, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    final bool canConfirm =
        _transactionIdController.text.isNotEmpty && !widget.isLoading;

    return AppButton(
      onPressed: canConfirm
          ? () {
              widget.onConfirmPayment(_transactionIdController.text.trim());
            }
          : null,
      text: 'Confirm Payment',
      bgColor: Colors.green,
      isLoading: widget.isLoading,
    );
  }

  @override
  void dispose() {
    _transactionIdController.dispose();
    super.dispose();
  }
}
