import 'package:book_store/app_themes/app_colors.dart';

import '../bloc/edit_profile_bloc.dart';
import 'edit_profile_loading.dart';
import '../views/avatar_selector.dart';
import '../views/birthday_selector.dart';
import '../views/gender_selector.dart';
import '../views/name_textfield.dart';
import '../views/phone_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc()..add(EditProfileLoadingEvent()),
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileNavigateState) {
            Navigator.of(context).pop(true);
          }
        },
        buildWhen: (previous, current) {
          return previous.isLoading != current.isLoading ||
              previous.showDialogLoading != current.showDialogLoading;
        },
        builder: (context, state) {
          if (state.isLoading) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.background,
              appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
              body: const EditProfileLoading(),
            );
          }
          return Stack(
            children: [
              Scaffold(
                extendBodyBehindAppBar: true,
                resizeToAvoidBottomInset: false,
                backgroundColor: AppColors.background,
                appBar:
                    AppBar(backgroundColor: Colors.transparent, elevation: 0),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const SizedBox(height: 250),
                        Image.asset(
                          'images/background.jpg',
                          height: 190,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: AvatarSelector(),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, top: 28),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              label('Tên của bạn'),
                              const NameEditorTextfield(),
                              const SizedBox(height: 14),
                              label('Số điện thoại'),
                              const PhoneEditorTextfield(),
                              const SizedBox(height: 14),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        label('Giới tính'),
                                        const GenderSelector(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        label('Ngày sinh'),
                                        const BirthdaySelector(),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 44,
                      margin:
                          const EdgeInsets.only(bottom: 14, left: 6, right: 6),
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<EditProfileBloc>(context).add(
                            const EditProfileChangingEvent(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Cập nhật',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              state.showDialogLoading
                  ? progressDialogue(context)
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }

  Widget label(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget progressDialogue(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.fourRotatingDots(
            color: Colors.white,
            size: 80,
          ),
          const SizedBox(
            height: 12,
          ),
          const Material(
            color: Colors.transparent,
            child: Text(
              'Đang cập nhật thông tin',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
