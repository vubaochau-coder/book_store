import 'package:book_store/screens/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme.dart';

class NameEditorTextfield extends StatefulWidget {
  const NameEditorTextfield({super.key});

  @override
  State<NameEditorTextfield> createState() => _NameEditorTextfieldState();
}

class _NameEditorTextfieldState extends State<NameEditorTextfield> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) {
        return previous.isNameErr != current.isNameErr;
      },
      builder: (context, state) {
        return TextField(
          style: const TextStyle(fontSize: 14),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            BlocProvider.of<EditProfileBloc>(context).add(
              UpdateNameEvent(name: value),
            );
          },
          decoration: InputDecoration(
            errorText: state.isNameErr ? 'Tối thiểu 6 ký tự' : null,
            hintText: state.name,
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
