class PhoneValidatorUtils {
  static bool isValidVietnamesePhoneNumber(String input) {
    final RegExp phoneRegex = RegExp(r'^0\d{9}$');

    return phoneRegex.hasMatch(input);
  }

  static bool isValidVietnamesePhoneNumberNew(String input) {
    final RegExp phoneRegex = RegExp(r'^(84|0[3|5|7|8|9])+([0-9]{8})$');

    return phoneRegex.hasMatch(input);
  }
}
