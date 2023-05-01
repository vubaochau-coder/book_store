import 'package:flutter/animation.dart';
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
