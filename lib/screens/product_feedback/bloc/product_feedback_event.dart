part of 'product_feedback_bloc.dart';

abstract class ProductFeedbackEvent extends Equatable {
  const ProductFeedbackEvent();

  @override
  List<Object> get props => [];
}

class ProductFeedbackLoadingEvent extends ProductFeedbackEvent {
  final String bookID;
  final List<FeedbackModel> allFeedbacks;

  const ProductFeedbackLoadingEvent({
    required this.bookID,
    required this.allFeedbacks,
  });
}

class ProductFeedbackFilterEvent extends ProductFeedbackEvent {
  final FeedbackTypes sortType;

  const ProductFeedbackFilterEvent({required this.sortType});
}

class ReportFeedbackEvent extends ProductFeedbackEvent {
  final String feedbackId;
  final String reportType;

  const ReportFeedbackEvent({
    required this.feedbackId,
    required this.reportType,
  });
}
