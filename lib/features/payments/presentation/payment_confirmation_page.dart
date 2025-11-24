import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_pos/features/payments/providers/payment_provider.dart';
import 'package:bus_pos/features/payments/data/payments_repository.dart';
import 'package:bus_pos/features/payments/data/payments_api.dart';
import 'package:bus_pos/common/widgets/payment_details_card.dart';
import 'package:bus_pos/common/widgets/payment_options_section.dart';
import 'package:bus_pos/common/widgets/loading_overlay.dart';

class PaymentConfirmationPage extends StatefulWidget {
  final String paymentId;
  final String initialTransactionId;

  const PaymentConfirmationPage({
    Key? key,
    required this.paymentId,
    required this.initialTransactionId,
  }) : super(key: key);

  @override
  State<PaymentConfirmationPage> createState() =>
      _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> {
  @override
  void initState() {
    super.initState();
    // Load payment details when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentProvider>().loadPaymentDetails(
        paymentId: widget.paymentId,
        transactionId: widget.initialTransactionId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Payment Confirmation'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<PaymentProvider>(
        builder: (context, paymentProvider, child) {
          // Show success screen if payment is confirmed
          if (paymentProvider.paymentConfirmed) {
            return _buildSuccessScreen(context);
          }

          // Show loading, error, or main content
          return _buildMainContent(context, paymentProvider);
        },
      ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    PaymentProvider paymentProvider,
  ) {
    // Show loading overlay when processing
    if (paymentProvider.isLoading && paymentProvider.paymentDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show error state
    if (paymentProvider.errorMessage.isNotEmpty &&
        paymentProvider.paymentDetails == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                'Failed to Load Payment Details',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.red),
              ),
              const SizedBox(height: 8),
              Text(
                paymentProvider.errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => paymentProvider.loadPaymentDetails(
                  paymentId: widget.paymentId,
                  transactionId: widget.initialTransactionId,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Payment Details Card - FROM FEATURE WIDGETS
              if (paymentProvider.paymentDetails != null)
                PaymentDetailsCard(
                  paymentDetails: paymentProvider.paymentDetails!,
                ),

              const SizedBox(height: 24),

              // Payment Options Section - FROM FEATURE WIDGETS
              PaymentOptionsSection(
                paymentId: widget.paymentId,
                initialTransactionId: widget.initialTransactionId,
                paymentDetails: paymentProvider.paymentDetails,
                isLoading: paymentProvider.isLoading,
                onConfirmPayment: (transactionId) {
                  paymentProvider.confirmPayment(
                    paymentId: widget.paymentId,
                    transactionId: transactionId,
                  );
                },
              ),

              // Error message (for confirmation errors)
              if (paymentProvider.errorMessage.isNotEmpty &&
                  paymentProvider.paymentDetails != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            paymentProvider.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Loading overlay for confirmation process - FROM COMMON WIDGETS
        if (paymentProvider.isLoading && paymentProvider.paymentDetails != null)
          LoadingOverlay(isLoading: paymentProvider.isLoading),
      ],
    );
  }

  Widget _buildSuccessScreen(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 24),
            Text(
              'Payment Confirmed!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your ticket payment has been successfully processed.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Transaction ID: ${widget.initialTransactionId}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate back or to tickets page
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// Provider setup wrapper (optional - can be in main.dart)
class PaymentConfirmationPageWrapper extends StatelessWidget {
  final String paymentId;
  final String initialTransactionId;

  const PaymentConfirmationPageWrapper({
    Key? key,
    required this.paymentId,
    required this.initialTransactionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<PaymentProvider>(
      create: (context) => PaymentProvider(repository: PaymentsRepository()),
      child: PaymentConfirmationPage(
        paymentId: paymentId,
        initialTransactionId: initialTransactionId,
      ),
    );
  }
}
