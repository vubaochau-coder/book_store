part of 'product_feedback_bloc.dart';

abstract class ProductFeedbackEvent extends Equatable {
  const ProductFeedbackEvent();

  @override
  List<Object> get props => [];
}

class ProductFeedbackLoadingEvent extends ProductFeedbackEvent {
  final String bookID;

  const ProductFeedbackLoadingEvent({
    required this.bookID,
  });
}

class ProductFeedbackFilterEvent extends ProductFeedbackEvent {
  final FeedbackTypes sortType;

  const ProductFeedbackFilterEvent({required this.sortType});
}
