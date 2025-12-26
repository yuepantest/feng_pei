import 'package:intl/intl.dart';

String setTime(DateTime dateTime) {
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  String formattedDateTime = formatter.format(dateTime);
  return formattedDateTime;
}

String formatNumber(num value) {
  return NumberFormat('#,###').format(value);
}