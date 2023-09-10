part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartLoadingEvent extends CartEvent {}

class CartUpdateEvent extends CartEvent {
  final List<CartItemModel> listCart;

  const CartUpdateEvent({required this.listCart});
}

class CartUpdateEmptyEvent extends CartEvent {}

class CartAllItemSelectedEvent extends CartEvent {
  const CartAllItemSelectedEvent();
}

class CartItemSelectedEvent extends CartEvent {
  final CartItemModel item;

  const CartItemSelectedEvent({required this.item});
}

class CartChangeItemQuantityEvent extends CartEvent {
  final CartItemModel item;
  final bool isIncrease;

  const CartChangeItemQuantityEvent(
      {required this.item, required this.isIncrease});
}

class CartRemoveItemEvent extends CartEvent {
  final String itemID;
  const CartRemoveItemEvent({required this.itemID});
}

class CartAddItemEvent extends CartEvent {
  final String itemID;

  const CartAddItemEvent({required this.itemID});
}
