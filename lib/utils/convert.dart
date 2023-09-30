import 'package:intl/intl.dart';

class Converter {
  static DateFormat dateFormat = DateFormat('dd/MM/yyyy h:mm a');
  static DateFormat dateFormat2 = DateFormat('dd/MM/yyyy');

  static String convertNumberToMoney(double number) {
    return NumberFormat.simpleCurrency()
        .format(number)
        .split('.')[0]
        .split('\$')[1];
  }

  static DateTime convertStringToDate(String dateString) {
    return dateFormat.parse(dateString);
  }

  static String convertDateToString(DateTime date) {
    return dateFormat.format(date);
  }

  static String convertDateToStringWithoutTime(DateTime date) {
    return dateFormat2.format(date);
  }

  static String convertTimeNoti(DateTime time) {
    return '${time.day}/${time.month.toString().padLeft(2, '0')} ${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}
