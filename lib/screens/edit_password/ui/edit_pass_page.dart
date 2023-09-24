import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/screens/edit_password/bloc/edit_pass_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  late TextEditingController _newPassController;
  late TextEditingController _confirmController;

  bool isHidePass = true;
  bool isHideConfirm = true;

  @override
  void initState() {
    super.initState();
    _newPassController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _newPassController.dispose();
    _confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPasswordBloc, EditPasswordState>(
      bloc: BlocProvider.of<EditPasswordBloc>(context)
        ..add(EditPasswordLoadingEvent()),
      listener: (context, state) {
        if (state is ChangePassSuccessfulState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is EditPassLoadingSuccessfulState) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.background,
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: AppColors.themeColor,
                  foregroundColor: AppColors.contentColor,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'Thay đổi mật khẩu',
                    style: AppTexts.appbarTitle,
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 144,
                      margin: const EdgeInsets.symmetric(vertical: 28),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/password.png'),
                          opacity: 0.6,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Text(
                        'Mật khẩu mới',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _newPassController,
                      cursorColor: AppColors.themeColor,
                      obscureText: isHidePass,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 0),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidePass = !isHidePass;
                            });
                          },
                          icon: Icon(
                            isHidePass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Text(
                        'Xác nhận mật khẩu mới',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _confirmController,
                      cursorColor: AppColors.themeColor,
                      obscureText: isHideConfirm,
                      decoration: InputDecoration(
                        errorText:
                            state.isConfirmErr ? state.confirmErrMsg : null,
                        errorMaxLines: 2,
                        fillColor: Colors.white,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 0),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHideConfirm = !isHideConfirm;
                            });
                          },
                          icon: Icon(
                            isHideConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      height: 44,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 14),
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<EditPasswordBloc>(context).add(
                            EditPasswordUpdateEvent(
                              newPass: _newPassController.text.trim(),
                              confirmNewPass: _confirmController.text.trim(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Xác nhận',
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
              state.isLoading ? progressDialogue(context) : const SizedBox(),
            ],
          );
        } else if (state is EditPassGgFbState) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.themeColor,
              foregroundColor: AppColors.contentColor,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Thay đổi mật khẩu',
                style: AppTexts.appbarTitle,
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 164,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/exclamation.png'),
                      opacity: 0.8,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: 332,
                  child: Text(
                    'Tính năng "Đổi mật khẩu" chỉ áp dụng cho phương thức đăng nhập bằng Email và Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.themeColor,
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text('Thay đổi mật khẩu'),
            ),
            body: const Center(
              child: Text('hehe'),
            ),
          );
        }
      },
    );
  }

  Widget progressDialogue(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: LoadingAnimationWidget.fourRotatingDots(
        color: Colors.white,
        size: 80,
      ),
    );
  }
}
