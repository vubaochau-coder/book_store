part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<ShortProductDataModel> products;
  final List<AdvertisingDataModel> advertisements;

  const HomeState({
    this.isLoading = true,
    this.products = const [],
    this.advertisements = const [],
  });

  @override
  List<Object> get props => [isLoading, products, advertisements];

  HomeState copyWith({
    bool? isLoading,
    List<ShortProductDataModel>? products,
    List<AdvertisingDataModel>? advertisements,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      advertisements: advertisements ?? this.advertisements,
    );
  }
}
