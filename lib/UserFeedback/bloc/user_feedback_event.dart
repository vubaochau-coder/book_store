part of 'user_feedback_bloc.dart';

abstract class UserFeedbackEvent extends Equatable {
  const UserFeedbackEvent();

  @override
  List<Object> get props => [];
}

class UserFeedbackLoadingEvent extends UserFeedbackEvent {}

class UserFeedbackUpdateEvent extends UserFeedbackEvent {
  final List<FeedbackItemModel> newListFeedback;
  final bool isLoading;

  const UserFeedbackUpdateEvent({
    required this.newListFeedback,
    required this.isLoading,
  });
}

class UserFeedbackUpdateEmptyEvent extends UserFeedbackEvent {}

class UserFeedbackSubmitEvent extends UserFeedbackEvent {
  final String feedbackID;
  final String bookID;
  final String review;
  final double rating;

  const UserFeedbackSubmitEvent({
    required this.feedbackID,
    required this.bookID,
    required this.review,
    required this.rating,
  });
}
