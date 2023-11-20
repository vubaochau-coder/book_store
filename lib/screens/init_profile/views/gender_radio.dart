import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/screens/init_profile/bloc/init_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderRadioButton extends StatelessWidget {
  const GenderRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitProfileBloc, InitProfileState>(
      buildWhen: (previous, current) {
        return previous.isMale != current.isMale;
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: true,
                    groupValue: state.isMale,
                    onChanged: (value) {
                      context
                          .read<InitProfileBloc>()
                          .add(const UpdateGenderEvent(isMale: true));
                    },
                    activeColor: AppColors.themeColor,
                  ),
                  const Text(
                    'Nam',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: false,
                    groupValue: state.isMale,
                    onChanged: (value) {
                      context
                          .read<InitProfileBloc>()
                          .add(const UpdateGenderEvent(isMale: false));
                    },
                    activeColor: AppColors.themeColor,
                  ),
                  const Text(
                    'Nữ',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
