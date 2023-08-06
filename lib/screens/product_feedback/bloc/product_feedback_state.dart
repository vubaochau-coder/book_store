part of 'product_feedback_bloc.dart';

abstract class ProductFeedbackState extends Equatable {
  const ProductFeedbackState();

  @override
  List<Object> get props => [];
}

class ProductFeedbackLoadingState extends ProductFeedbackState {}

class ProductFeedbackLoadedState extends ProductFeedbackState {
  final int sortType;
  final List<FeedbackModel> feedbacks;

  const ProductFeedbackLoadedState({
    required this.sortType,
    required this.feedbacks,
  });

  @override
  List<Object> get props => [sortType, feedbacks];
}
