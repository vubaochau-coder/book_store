import 'package:book_store/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme.dart';

class PhoneEditorTextfield extends StatefulWidget {
  const PhoneEditorTextfield({super.key});

  @override
  State<PhoneEditorTextfield> createState() => _PhoneEditorTextfieldState();
}

class _PhoneEditorTextfieldState extends State<PhoneEditorTextfield> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) {
        return previous.isPhoneErr != current.isPhoneErr;
      },
      builder: (context, state) {
        return TextField(
          style: const TextStyle(fontSize: 14),
          onChanged: (value) {
            BlocProvider.of<EditProfileBloc>(context).add(
              UpdatePhoneEvent(phone: value),
            );
          },
          decoration: InputDecoration(
            errorText: state.isPhoneErr ? 'Số điện thoại không hợp lệ' : null,
            hintText: state.phone == '' ? 'Chưa cập nhật' : state.phone,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            focusedErrorBorder: textFieldBorder3,
            enabledBorder: textFieldBorder3,
            focusedBorder: textFieldBorder3,
            errorBorder: textFieldBorder3,
          ),
        );
      },
    );
  }
}
