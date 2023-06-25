part of 'cart_count_bloc.dart';

abstract class CartCountEvent extends Equatable {
  const CartCountEvent();

  @override
  List<Object> get props => [];
}

class CartCountLoadingEvent extends CartCountEvent {}

class CartCountUpdateEvent extends CartCountEvent {
  final int cartNumber;

  const CartCountUpdateEvent({required this.cartNumber});

  @override
  List<Object> get props => [cartNumber];
}
