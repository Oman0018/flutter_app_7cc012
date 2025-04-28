import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String isoDate) {
    final DateTime date = DateTime.parse(isoDate);
    return DateFormat.yMMMd().format(date);
  }
}
