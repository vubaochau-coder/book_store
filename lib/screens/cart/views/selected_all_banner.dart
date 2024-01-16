import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/screens/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedAllBanner extends StatelessWidget {
  const SelectedAllBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) {
        return previous.isAllSelected != current.isAllSelected;
      },
      builder: (context, state) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.white,
          surfaceTintColor: Colors.white,
          margin: const EdgeInsets.only(bottom: 4),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Checkbox(
                  activeColor: AppColors.themeColor,
                  value: state.isAllSelected,
                  onChanged: (value) {
                    BlocProvider.of<CartBloc>(context).add(
                      const CartAllItemSelectedEvent(),
                    );
                  },
                ),
                Text(
                  'Chọn tất cả (${state.cartItems.length} sản phẩm)',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
