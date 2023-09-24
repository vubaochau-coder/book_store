part of 'product_feedback_bloc.dart';

enum FeedbackTypes { all, one, two, three, four, five }

class ProductFeedbackState extends Equatable {
  final bool isLoading;
  final FeedbackTypes sortType;
  final List<FeedbackModel> allFeedbacks;
  final List<FeedbackModel> showedFeedbacks;

  const ProductFeedbackState({
    this.isLoading = true,
    this.sortType = FeedbackTypes.all,
    this.allFeedbacks = const [],
    this.showedFeedbacks = const [],
  });

  @override
  List<Object> get props =>
      [isLoading, sortType, allFeedbacks, showedFeedbacks];

  ProductFeedbackState copyWith({
    bool? isLoading,
    FeedbackTypes? sortType,
    List<FeedbackModel>? allFeedbacks,
    List<FeedbackModel>? showedFeedbacks,
  }) {
    return ProductFeedbackState(
      isLoading: isLoading ?? this.isLoading,
      sortType: sortType ?? this.sortType,
      allFeedbacks: allFeedbacks ?? this.allFeedbacks,
      showedFeedbacks: showedFeedbacks ?? this.showedFeedbacks,
    );
  }
}
