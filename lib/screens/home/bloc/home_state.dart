part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeLoadingSuccessfulState extends HomeState {
  final List<ShortProductDataModel> products;
  final List<AdvertisingDataModel> advertisements;

  const HomeLoadingSuccessfulState({
    required this.products,
    required this.advertisements,
  });

  @override
  List<Object> get props => [products, advertisements];
}
