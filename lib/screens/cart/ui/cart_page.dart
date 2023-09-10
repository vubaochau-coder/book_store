import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/screens/cart/views/bottom_button.dart';
import 'package:book_store/screens/cart/views/list_cart_items.dart';
import 'package:book_store/screens/cart/views/selected_all_banner.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        elevation: 0,
        title: Text(
          'Giỏ hàng',
          style: AppTexts.appbarTitle,
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SelectedAllBanner(),
                Expanded(
                  child: ListCartItems(),
                ),
              ],
            ),
          ),
          BottomButton(),
        ],
      ),
    );
  }
}
