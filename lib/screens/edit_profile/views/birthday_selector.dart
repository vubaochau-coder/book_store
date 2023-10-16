import 'package:book_store/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../theme.dart';

class BirthdaySelector extends StatelessWidget {
  const BirthdaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) {
        return previous.isLoading != current.isLoading ||
            previous.birthday != current.birthday ||
            previous.isBirthdayErr != current.isBirthdayErr;
      },
      builder: (context, state) {
        return TextField(
          readOnly: true,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            errorText:
                state.isBirthdayErr ? 'Ngày sinh không được trống' : null,
            hintText: state.birthday == '' ? 'Chưa cập nhật' : state.birthday,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            focusedErrorBorder: textFieldBorder3,
            enabledBorder: textFieldBorder3,
            focusedBorder: textFieldBorder3,
            errorBorder: textFieldBorder3,
            suffixIcon: IconButton(
              onPressed: () {
                showDatePicker(
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                        primary: themeColor,
                        onPrimary: Colors.white,
                      )),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                ).then((value) {
                  if (value != null) {
                    BlocProvider.of<EditProfileBloc>(context).add(
                      UpdateBirthdayEvent(
                          birthday: DateFormat('dd/MM/yyyy').format(value)),
                    );
                  }
                });
              },
              icon: Icon(Icons.calendar_month, color: themeColor),
            ),
          ),
        );
      },
    );
  }
}
