import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/authentication_service/auth_service.dart';
import 'package:book_store/screens/login_register/forgot_page.dart';
import 'package:book_store/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class DefaultLoginPage extends StatefulWidget {
  final VoidCallback onRegisterTapped;
  const DefaultLoginPage({super.key, required this.onRegisterTapped});

  @override
  State<DefaultLoginPage> createState() => _DefaultLoginPageState();
}

class _DefaultLoginPageState extends State<DefaultLoginPage> {
  bool isVerifying = false;

  bool isUnShowPass = true;
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passLoginController = TextEditingController();

  bool emailValidate = false;
  String emailLoginError = '';
  bool passValidate = false;
  String passLoginError = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 14,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Đăng nhập',
                style: TextStyle(
                  color: AppColors.themeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 29),
              TextField(
                controller: emailLoginController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: emailValidate ? emailLoginError : null,
                  hintText: 'Email đăng nhập',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  focusedErrorBorder: textFieldBorder,
                  enabledBorder: textFieldBorder,
                  focusedBorder: textFieldBorder,
                  errorBorder: textFieldBorder,
                  prefixIcon: Icon(
                    Icons.person,
                    color: themeColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passLoginController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  errorText: passValidate ? passLoginError : null,
                  hintText: 'Mật khẩu',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  focusedErrorBorder: textFieldBorder,
                  enabledBorder: textFieldBorder,
                  focusedBorder: textFieldBorder,
                  errorBorder: textFieldBorder,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppColors.themeColor,
                  ),
                  suffixIcon: IconButton(
                    color: AppColors.themeColor,
                    icon: isUnShowPass
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: () => setState(() {
                      isUnShowPass = !isUnShowPass;
                    }),
                  ),
                ),
                obscureText: isUnShowPass,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const ForgotPasswordPage();
                        },
                      ));
                    },
                    child: Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(top: 14, bottom: 18),
                child: ElevatedButton(
                  onPressed: isVerifying
                      ? null
                      : () {
                          loginByEmailAndPass(emailLoginController.text.trim(),
                              passLoginController.text.trim());
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
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
                          'Đăng nhập',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Chưa có tài khoản?'),
                  TextButton(
                    onPressed: isVerifying ? null : widget.onRegisterTapped,
                    child: Text(
                      'Đăng ký ngay',
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.black54, indent: 2),
                  ),
                  SizedBox(width: 2),
                  Text(
                    'hoặc Đăng nhập bằng',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black54,
                      indent: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: isVerifying
                        ? null
                        : () {
                            AuthService().signInWithGoogle();
                          },
                    child: Image.asset(
                      'images/google.png',
                      height: 42,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 42, height: 68),
                  GestureDetector(
                    onTap: isVerifying
                        ? null
                        : () {
                            AuthService().signInWithFacebook();
                          },
                    child: Image.asset(
                      'images/facebook.png',
                      height: 42,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginByEmailAndPass(String email, String pass) async {
    setState(() {
      emailValidate = false;
      passValidate = false;
      isVerifying = true;
    });

    if (email.isNotEmpty && pass.isNotEmpty && pass.length >= 6) {
      if (EmailValidator.validate(email)) {
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: pass)
              .whenComplete(() {
            if (mounted) {
              setState(() {
                isVerifying = false;
              });
            }
          });
        } on FirebaseAuthException catch (error) {
          if (error.code == 'invalid-email') {
            setState(() {
              emailValidate = true;
              emailLoginError = 'Firebase: Email không hợp lệ';
              //isVerifying = false;
            });
          }
          if (error.code == 'user-disabled') {
            setState(() {
              emailValidate = true;
              emailLoginError = 'Firebase: Tài khoản đã bị vô hiệu hóa';
              //isVerifying = false;
            });
          }
          if (error.code == 'user-not-found') {
            setState(() {
              emailValidate = true;
              emailLoginError =
                  'Firebase: Không tồn tại người dùng với email trên';
              //isVerifying = false;
            });
          }
          if (error.code == 'wrong-password') {
            setState(() {
              passValidate = true;
              passLoginError = 'Firebase: Sai mật khẩu';
              //isVerifying = false;
            });
          }
        }
      } else {
        setState(() {
          emailValidate = true;
          emailLoginError = 'Vui lòng nhập đúng định dạng email';
          isVerifying = false;
        });
      }
    } else {
      if (email.isEmpty) {
        setState(() {
          emailValidate = true;
          emailLoginError = 'Email không được bỏ trống';
          isVerifying = false;
        });
      }
      if (pass.isEmpty) {
        setState(() {
          passValidate = true;
          passLoginError = 'Mật khẩu phải có độ dài từ 6 ký tự';
          isVerifying = false;
        });
      }
      if (pass.length < 6) {
        setState(() {
          passValidate = true;
          passLoginError = 'Mật khẩu phải có độ dài từ 6 ký tự';
          isVerifying = false;
        });
      }
    }
  }
}
