import 'package:flutter/material.dart';

Color themeColor = const Color(0xffe65728);

InputBorder textFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: BorderSide.none,
);

InputBorder textFieldBorder2 = OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: BorderSide(
    color: themeColor,
    width: 1,
  ),
);

InputBorder textFieldBorder3 = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(
    color: Colors.black,
    width: 1,
  ),
);

TextStyle text1 = const TextStyle(
  color: Colors.black87,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

TextStyle text2 = const TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.w500,
);
