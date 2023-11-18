import 'package:book_store/screens/init_profile/bloc/init_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_themes/app_colors.dart';

class BirthdaySelector extends StatefulWidget {
  final String intiText;
  const BirthdaySelector({super.key, required this.intiText});

  @override
  State<BirthdaySelector> createState() => _BirthdaySelectorState();
}

class _BirthdaySelectorState extends State<BirthdaySelector> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
      text: widget.intiText.isNotEmpty ? widget.intiText : null,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BirthdaySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.intiText.isNotEmpty) {
      _controller.text = widget.intiText;
    } else {
      _controller.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 14),
      controller: _controller,
      readOnly: true,
      onTap: () {
        pickDateTime(context).then((value) {
          if (value != null) {
            context
                .read<InitProfileBloc>()
                .add(UpdateBirthdayEvent(birthday: value));
          }
        });
      },
      decoration: InputDecoration(
        hintText: "dd/MM/yyyy",
        hintStyle: const TextStyle(fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.themeColor, width: 2),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            pickDateTime(context).then((value) {
              if (value != null) {
                context
                    .read<InitProfileBloc>()
                    .add(UpdateBirthdayEvent(birthday: value));
              }
            });
          },
          icon: Icon(Icons.calendar_month, color: AppColors.themeColor),
        ),
      ),
    );
  }

  Future<DateTime?> pickDateTime(context) async {
    DateTime? res = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
            primary: AppColors.themeColor,
            onPrimary: Colors.white,
          )),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return res;
  }
}
