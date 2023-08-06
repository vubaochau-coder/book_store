import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TransactionLoadingPage extends StatelessWidget {
  const TransactionLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.horizontalRotatingDots(
        color: themeColor,
        size: 60,
      ),
    );
  }
}
