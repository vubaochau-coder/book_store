import 'package:book_store/screens/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/cart_item.dart';

class ListCartItems extends StatelessWidget {
  const ListCartItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) {
        return previous.selectedCartitems != current.selectedCartitems ||
            previous.cartItems != current.cartItems;
      },
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return CartItem(
              isSelected:
                  state.selectedCartitems.contains(state.cartItems[index]),
              cartData: state.cartItems[index],
              onDecrease: () {
                BlocProvider.of<CartBloc>(context).add(
                  CartChangeItemQuantityEvent(
                    item: state.cartItems[index],
                    isIncrease: false,
                  ),
                );
              },
              onIncrease: () {
                BlocProvider.of<CartBloc>(context).add(
                  CartChangeItemQuantityEvent(
                    item: state.cartItems[index],
                    isIncrease: true,
                  ),
                );
              },
              onRemove: () {
                BlocProvider.of<CartBloc>(context).add(
                  CartRemoveItemEvent(itemID: state.cartItems[index].id),
                );
              },
              onSelected: (bool? value) {
                BlocProvider.of<CartBloc>(context).add(
                  CartItemSelectedEvent(
                    item: state.cartItems[index],
                  ),
                );
              },
            );
          },
          itemCount: state.cartItems.length,
        );
      },
    );
  }
}
