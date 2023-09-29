part of 'product_bloc.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final bool isFavorited;
  final ProductDataModel? productData;
  final List<FeedbackModel> feedbacks;
  final List<FeedbackModel> allFeedbacks;

  const ProductState({
    this.isLoading = true,
    this.isFavorited = false,
    this.productData,
    this.feedbacks = const [],
    this.allFeedbacks = const [],
  });

  @override
  List<Object?> get props =>
      [isLoading, isFavorited, productData, feedbacks, allFeedbacks];

  ProductState copyWith({
    bool? isLoading,
    bool? isFavorited,
    ProductDataModel? productData,
    List<FeedbackModel>? feedbacks,
    List<FeedbackModel>? allFeedbacks,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      isFavorited: isFavorited ?? this.isFavorited,
      feedbacks: feedbacks ?? this.feedbacks,
      productData: productData ?? this.productData,
      allFeedbacks: allFeedbacks ?? this.allFeedbacks,
    );
  }
}

// class ProductLoadingState extends ProductState {}

// class ProductLoadingSuccesfulSatte extends ProductState {
//   final bool isFavorited;
//   final ProductDataModel productData;
//   final List<FeedbackModel> feedbacks;
//   final int totalFeedback;

//   const ProductLoadingSuccesfulSatte({
//     required this.productData,
//     required this.isFavorited,
//     required this.feedbacks,
//     required this.totalFeedback,
//   });

//   @override
//   List<Object> get props =>
//       [isFavorited, feedbacks, productData, totalFeedback];
// }
