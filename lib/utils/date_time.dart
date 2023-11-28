import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateFormat monthCol = DateFormat("MM_yyyy");

  static String monthCollection(DateTime dateTime) {
    return monthCol.format(dateTime);
  }

  static String orderTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('HH:mm dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }
}
