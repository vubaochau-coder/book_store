part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItemModel> cartItems;
  final List<CartItemModel> selectedCartitems;
  final bool isAllSelected;
  final bool isLoading;

  const CartState({
    this.cartItems = const [],
    this.selectedCartitems = const [],
    this.isLoading = false,
    this.isAllSelected = false,
  });

  @override
  List<Object> get props =>
      [cartItems, isLoading, isAllSelected, selectedCartitems];

  CartState copyWith({
    bool? isLoading,
    bool? isAllSelected,
    List<CartItemModel>? cartItems,
    List<CartItemModel>? selectedCartitems,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      isAllSelected: isAllSelected ?? this.isAllSelected,
      selectedCartitems: selectedCartitems ?? this.selectedCartitems,
    );
  }
}
