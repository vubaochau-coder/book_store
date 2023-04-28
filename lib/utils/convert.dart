import 'package:intl/intl.dart';

class Converter {
  static String convertNumberToMoney(double number) {
    return NumberFormat.simpleCurrency()
        .format(number)
        .split('.')[0]
        .split('\$')[1];
  }

  static DateTime convertStringToDate(String dateString) {
    return DateFormat("dd/MM/yyyy").parse(dateString);
  }
}
