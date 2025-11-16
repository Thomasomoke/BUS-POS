import 'package:bus_pos/common/widgets/app_button.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final String message;
  final VoidCallback? onCancel;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    this.message = "Loading...",
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();

    return Stack(
      children: [
        // Background dimming layer
        ModalBarrier(color: Colors.black.withOpacity(0.5), dismissible: false),

        Center(
          child: Container(
            width: 220,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),
                const CircularProgressIndicator(color: Colors.blue),
                const SizedBox(height: 18),
                Text(message, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                if (onCancel != null)
                  AppButton(
                    onPressed: onCancel,
                    text: "Cancel",
                    bgColor: Colors.grey,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
