import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  return "KES ${amount.toStringAsFixed(2)}";
}

String formatDate(DateTime date) {
  return DateFormat("d MMMM yyyy").format(date);
}
