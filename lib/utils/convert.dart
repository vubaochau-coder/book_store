import 'package:intl/intl.dart';

class Converter {
  static DateFormat dateFormat = DateFormat('dd/MM/yyyy');

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
}
