import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isVerifying = false;
  TextEditingController emailController = TextEditingController();
  bool emailForgotValidate = false;
  String emailForgotError = '';
  bool sendSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Quên mật khẩu',
          style: AppTexts.appbarTitle.copyWith(color: AppColors.themeColor),
        ),
        centerTitle: true,
        foregroundColor: AppColors.themeColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 240,
                width: double.infinity,
                child: Center(
                  child: Image.asset('images/forgotpassword.png'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Email đăng nhập của bạn là',
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: emailForgotValidate ? emailForgotError : null,
                  prefixIcon: Icon(
                    Icons.mail,
                    color: themeColor,
                  ),
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: textFieldBorder2,
                  focusedBorder: textFieldBorder2,
                  errorBorder: textFieldBorder2,
                  focusedErrorBorder: textFieldBorder2,
                ),
              ),
              sendSuccess
                  ? const Text(
                      'Mail khôi phục mật khẩu đã được gửi thành công, vui lòng kiểm tra hộp thư để hoàn tất việc khôi phục mật khẩu',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(),
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(top: 34, bottom: 18),
                child: ElevatedButton(
                  onPressed: isVerifying
                      ? null
                      : () {
                          sendEmailResetPasswordToEmail(
                              emailController.text.trim());
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: isVerifying
                      ? JumpingDots(
                          color: Colors.white,
                          animationDuration: const Duration(milliseconds: 200),
                          verticalOffset: 10,
                        )
                      : const Text(
                          'Khôi phục mật khẩu',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendEmailResetPasswordToEmail(String email) async {
    setState(() {
      emailForgotValidate = false;
      isVerifying = true;
      sendSuccess = false;
    });
    if (email.isNotEmpty) {
      if (EmailValidator.validate(email)) {
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: email)
              .then((value) {
            setState(() {
              sendSuccess = true;
            });
          }).whenComplete(() {
            setState(() {
              isVerifying = false;
            });
          });
        } on FirebaseAuthException catch (error) {
          if (error.code == 'invalid-email') {
            setState(() {
              emailForgotValidate = true;
              emailForgotError = 'Firebase: Vui lòng nhập đúng định dạng email';
            });
          }
          if (error.code == 'user-not-found') {
            setState(() {
              emailForgotValidate = true;
              emailForgotError =
                  'Firebase: Không tồn tại người dùng với email trên';
            });
          }
        }
      } else {
        setState(() {
          isVerifying = false;
          emailForgotValidate = true;
          emailForgotError = 'Vui lòng nhập đúng định dạng email';
        });
      }
    } else {
      setState(() {
        isVerifying = false;
        emailForgotValidate = true;
        emailForgotError = 'Email không được bỏ trống';
      });
    }
  }
}
