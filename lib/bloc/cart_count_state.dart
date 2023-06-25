part of 'cart_count_bloc.dart';

abstract class CartCountState extends Equatable {
  const CartCountState();

  @override
  List<Object> get props => [];
}

class CartCountLoadingState extends CartCountState {}

class CartCountLoadingSuccessfulState extends CartCountState {
  final int cartNumber;

  const CartCountLoadingSuccessfulState({required this.cartNumber});

  @override
  List<Object> get props => [cartNumber];
}
