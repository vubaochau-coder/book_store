import 'package:flutter/material.dart';

import '../theme.dart';

class DefaultRegisterPage extends StatelessWidget {
  final VoidCallback onLoginTapped;
  const DefaultRegisterPage({super.key, required this.onLoginTapped});

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
        body: Column(
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
            const Spacer(),
            TextField(
              decoration: simpleInputDecoration('Tên đăng nhập', Icons.person),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: simpleInputDecoration('Mật khẩu', Icons.lock),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration:
                  simpleInputDecoration('Xác nhận mật khẩu', Icons.lock_reset),
            ),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(top: 14, bottom: 18),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
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
                  onPressed: onLoginTapped,
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: themeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    color: Colors.black54,
                    indent: 2,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'images/google.png',
                    height: 42,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  width: 42,
                  height: 68,
                ),
                GestureDetector(
                  onTap: () {},
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
    );
  }

  InputDecoration simpleInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(
        icon,
        color: themeColor,
      ),
    );
  }
}
