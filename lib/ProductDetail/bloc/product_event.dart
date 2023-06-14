part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductLoadingEvent extends ProductEvent {
  final String idProduct;

  const ProductLoadingEvent({required this.idProduct});
}

class ProductFavoriteEvent extends ProductEvent {
  final String idProduct;

  const ProductFavoriteEvent({required this.idProduct});
}
