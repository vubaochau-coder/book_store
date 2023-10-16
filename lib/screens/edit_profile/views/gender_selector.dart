import 'package:book_store/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) {
        return previous.isLoading != current.isLoading ||
            previous.isMale != current.isMale;
      },
      builder: (context, state) {
        return DropdownButtonFormField2(
          value: state.isMale ? 'Nam' : 'Nữ',
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            enabledBorder: textFieldBorder3,
            focusedBorder: textFieldBorder3,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 4,
          ),
          isExpanded: true,
          buttonStyleData: const ButtonStyleData(
            height: 48,
            padding: EdgeInsets.only(right: 8),
          ),
          items: const [
            DropdownMenuItem(
              value: 'Nam',
              child: Text(
                'Nam',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            DropdownMenuItem(
              value: 'Nữ',
              child: Text(
                'Nữ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              BlocProvider.of<EditProfileBloc>(context).add(
                UpdateGenderEvent(isMale: value == 'Nam'),
              );
            }
          },
        );
      },
    );
  }
}
