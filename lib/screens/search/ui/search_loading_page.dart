import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchLoadingPage extends StatelessWidget {
  const SearchLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 62,
        titleSpacing: 10,
        title: SizedBox(
          height: 36,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 4),
                Icon(
                  Icons.search,
                  color: themeColor,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Tìm kiếm sản phẩm',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: LoadingAnimationWidget.horizontalRotatingDots(
          color: themeColor,
          size: 60,
        ),
      ),
    );
  }
}
