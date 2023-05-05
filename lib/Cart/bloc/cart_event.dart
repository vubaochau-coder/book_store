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
  final List<CartItemModel> listCart;

  const CartAllItemSelectedEvent({required this.listCart});
}

class CartItemSelectedEvent extends CartEvent {
  final String itemID;
  final List<CartItemModel> listCart;

  const CartItemSelectedEvent({required this.itemID, required this.listCart});
}

class CartChangeItemQuantityEvent extends CartEvent {
  final String itemID;
  final bool isIncrease;
  final List<CartItemModel> listCart;

  const CartChangeItemQuantityEvent(
      {required this.itemID, required this.isIncrease, required this.listCart});
}

class CartRemoveItemEvent extends CartEvent {
  final String itemID;
  const CartRemoveItemEvent({required this.itemID});
}

class CartAddItemEvent extends CartEvent {
  final String itemID;

  const CartAddItemEvent({required this.itemID});
}
