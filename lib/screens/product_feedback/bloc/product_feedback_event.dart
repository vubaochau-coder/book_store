part of 'product_feedback_bloc.dart';

abstract class ProductFeedbackEvent extends Equatable {
  const ProductFeedbackEvent();

  @override
  List<Object> get props => [];
}

class ProductFeedbackLoadingEvent extends ProductFeedbackEvent {
  final int sortOption;
  final String bookID;

  const ProductFeedbackLoadingEvent({
    required this.sortOption,
    required this.bookID,
  });
}
