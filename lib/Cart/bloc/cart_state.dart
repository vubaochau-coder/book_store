part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoadingState extends CartState {}

class CartLoadingSuccessfulState extends CartState {
  final List<CartItemModel> cartItems;

  const CartLoadingSuccessfulState({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

class CartEmptyState extends CartState {}
