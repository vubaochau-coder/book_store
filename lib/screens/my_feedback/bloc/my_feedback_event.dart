part of 'my_feedback_bloc.dart';

abstract class MyFeedbackEvent extends Equatable {
  const MyFeedbackEvent();

  @override
  List<Object> get props => [];
}

class MyFeedbackLoadingEvent extends MyFeedbackEvent {}

class MyFeedbackUpdateEvent extends MyFeedbackEvent {
  final List<FeedbackItemModel> newListFeedback;
  final bool isLoading;

  const MyFeedbackUpdateEvent({
    required this.newListFeedback,
    required this.isLoading,
  });
}

class MyFeedbackUpdateEmptyEvent extends MyFeedbackEvent {}

class MyFeedbackSubmitEvent extends MyFeedbackEvent {
  final String feedbackID;
  final String bookID;
  final String review;
  final double rating;

  const MyFeedbackSubmitEvent({
    required this.feedbackID,
    required this.bookID,
    required this.review,
    required this.rating,
  });
}
