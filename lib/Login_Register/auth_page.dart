import 'package:book_store/Login_Register/default_login.dart';
import 'package:book_store/Login_Register/default_register.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final controller = PageController(initialPage: 0);
  final backgroundController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: themeColor.withAlpha(200),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'images/logo_trans.png',
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    PageView(
                      controller: backgroundController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          height: 540,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 60,
                          ),
                        ),
                        Container(
                          height: 540,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 60,
                          ),
                        ),
                      ],
                    ),
                    PageView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        DefaultLoginPage(onRegisterTapped: moveToRegisterPage),
                        DefaultRegisterPage(onLoginTapped: moveToLoginPage),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void moveToRegisterPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
    );
    backgroundController.previousPage(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
    );
  }

  void moveToLoginPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
    );
    backgroundController.nextPage(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
    );
  }
}
