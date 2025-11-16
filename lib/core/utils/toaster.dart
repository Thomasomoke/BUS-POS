import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

void showToast(BuildContext context, String message, {bool isError = false}) {
  DelightToastBar(
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
    snackbarDuration: Duration(seconds: 3),
    builder: (context) => ToastCard(
      leading: Icon(
        isError ? Icons.error_outline : Icons.flutter_dash,
        size: 28,
        color: isError
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).primaryColor,
      ),
      title: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    ),
  ).show(context);
}
