import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/authentication_service/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

import '../../theme.dart';

class DefaultRegisterPage extends StatefulWidget {
  final VoidCallback onLoginTapped;
  const DefaultRegisterPage({super.key, required this.onLoginTapped});

  @override
  State<DefaultRegisterPage> createState() => _DefaultRegisterPageState();
}

class _DefaultRegisterPageState extends State<DefaultRegisterPage> {
  bool isVerifying = false;

  bool isUnShowPass = true;

  bool emailValidate = false;
  String emailRegisterError = '';

  bool passValidate = false;
  String passRegisterError = '';

  bool confirmPassValidate = false;
  String confirmPassRegisterError = '';

  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController passRegisterController = TextEditingController();
  TextEditingController rePassRegisterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 60,
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
                'Đăng ký',
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 17),
              TextField(
                controller: emailRegisterController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: emailValidate ? emailRegisterError : null,
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
                    color: AppColors.themeColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passRegisterController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  errorText: passValidate ? passRegisterError : null,
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
                    color: themeColor,
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
              const SizedBox(height: 12),
              TextField(
                controller: rePassRegisterController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  errorText:
                      confirmPassValidate ? confirmPassRegisterError : null,
                  hintText: 'Xác nhận mật khẩu',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  focusedErrorBorder: textFieldBorder,
                  enabledBorder: textFieldBorder,
                  focusedBorder: textFieldBorder,
                  errorBorder: textFieldBorder,
                  prefixIcon: Icon(
                    Icons.lock_reset,
                    color: AppColors.themeColor,
                  ),
                  suffixIcon: IconButton(
                    color: themeColor,
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
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(top: 14, bottom: 18),
                child: ElevatedButton(
                  onPressed: isVerifying
                      ? null
                      : () => createAccountUser(
                          emailRegisterController.text.trim(),
                          passRegisterController.text.trim(),
                          rePassRegisterController.text.trim()),
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
                          'Đăng ký',
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
                  const Text('Đã có tài khoản?'),
                  TextButton(
                    onPressed: isVerifying ? null : widget.onLoginTapped,
                    child: Text(
                      'Đăng nhập',
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
                    child: Divider(color: Colors.black54, indent: 2),
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

  bool isConfirmPassMatched(String pass, String confirmPass) {
    if (pass != confirmPass) {
      return false;
    }
    return true;
  }

  createAccountUser(String email, String pass, String confirmPass) async {
    setState(() {
      emailValidate = false;
      passValidate = false;
      confirmPassValidate = false;
      isVerifying = true;
    });

    if (email.isNotEmpty && pass.isNotEmpty && confirmPass.isNotEmpty) {
      if (EmailValidator.validate(email)) {
        if (pass.length >= 6) {
          if (isConfirmPassMatched(pass, confirmPass)) {
            try {
              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(email: email, password: pass)
                  .then((value) async {
                await FirebaseAuth.instance.currentUser
                    ?.updateDisplayName(email);
                await FirebaseAuth.instance.currentUser?.updatePhotoURL(
                    'https://firebasestorage.googleapis.com/v0/b/da1-bookstore.appspot.com/o/Avatar%2Fdefault.png?alt=media&token=5b785b82-3fe3-4866-a056-cbd29a69cbde');
              }).whenComplete(() {
                setState(() {
                  isVerifying = false;
                });
              });
            } on FirebaseAuthException catch (error) {
              if (error.code == 'email-already-in-use') {
                confirmPassRegisterError = 'Firebase: Email đã được đăng ký';
                setState(() {
                  confirmPassValidate = true;
                  //isVerifying = false;
                });
              }
              if (error.code == 'invalid-email') {
                confirmPassRegisterError = 'Firebase: Email không hợp lệ';
                setState(() {
                  confirmPassValidate = true;
                  //isVerifying = false;
                });
              }
              if (error.code == 'operation-not-allowed') {
                confirmPassRegisterError = 'Firebase: Email đã bị vô hiệu hóa';
                setState(() {
                  confirmPassValidate = true;
                  //isVerifying = false;
                });
              }
              if (error.code == 'weak-password') {
                confirmPassRegisterError = 'Firebase: Mật khẩu không đủ mạnh';
                setState(() {
                  confirmPassValidate = true;
                  //isVerifying = false;
                });
              }
            }
          } else {
            setState(() {
              confirmPassValidate = true;
              confirmPassRegisterError = 'Mật khẩu không trùng khớp';
              isVerifying = false;
            });
          }
        } else {
          setState(() {
            passValidate = true;
            passRegisterError = 'Mật khẩu phải có độ dài từ 6 ký tự';
            isVerifying = false;
          });
        }
      } else {
        setState(() {
          emailValidate = true;
          emailRegisterError = 'Vui lòng nhập đúng định dạng email';
          isVerifying = false;
        });
      }
    } else {
      if (email.isEmpty) {
        setState(() {
          emailValidate = true;
          emailRegisterError = 'Email không được bỏ trống';
          isVerifying = false;
        });
      }
      if (pass.isEmpty) {
        setState(() {
          passValidate = true;
          passRegisterError = 'Mật khẩu không được bỏ trống';
          isVerifying = false;
        });
      }
      if (confirmPass.isEmpty) {
        setState(() {
          confirmPassValidate = true;
          confirmPassRegisterError = 'Mật khẩu xác nhận không được bỏ trống';
          isVerifying = false;
        });
      }
    }
  }
}
