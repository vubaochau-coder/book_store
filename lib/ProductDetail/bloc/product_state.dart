part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {}

class ProductLoadingSuccesfulSatte extends ProductState {
  final bool isFavorited;
  final ProductDataModel productData;
  final List<FeedbackModel> feedbacks;
  final int totalFeedback;

  const ProductLoadingSuccesfulSatte({
    required this.productData,
    required this.isFavorited,
    required this.feedbacks,
    required this.totalFeedback,
  });

  @override
  List<Object> get props =>
      [isFavorited, feedbacks, productData, totalFeedback];
}
