import 'package:flutter/material.dart';

import '../../../app_themes/app_colors.dart';

class ProfileTextField extends StatelessWidget {
  final String hintText;
  final String errorText;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function onEditingComplete;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;

  const ProfileTextField({
    super.key,
    required this.hintText,
    required this.errorText,
    required this.focusNode,
    required this.onChanged,
    required this.onEditingComplete,
    this.keyboardType,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onChanged: onChanged,
      onEditingComplete: () {
        focusNode.unfocus();
        onEditingComplete();
      },
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.themeColor, width: 2),
        ),
        errorText: errorText.isNotEmpty ? errorText : null,
      ),
    );
  }
}
