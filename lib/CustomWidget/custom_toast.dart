import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyCustomToast {
  static showToast(String msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Image.asset('images/logo_fill_crop.png'),
          ),
          Expanded(
            flex: 6,
            child: Text(msg),
          ),
        ],
      ),
    );

    FToast fToast = FToast();
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
