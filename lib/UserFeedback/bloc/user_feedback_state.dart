part of 'user_feedback_bloc.dart';

abstract class UserFeedbackState extends Equatable {
  const UserFeedbackState();

  @override
  List<Object> get props => [];
}

class UserFeedbackLoadingState extends UserFeedbackState {}

class UserFeedbackLoadingSuccessfulState extends UserFeedbackState {
  final List<FeedbackItemModel> listFeedback;
  final bool isLoading;

  const UserFeedbackLoadingSuccessfulState({
    required this.listFeedback,
    required this.isLoading,
  });

  @override
  List<Object> get props => [listFeedback, isLoading];
}

class UserFeedbackEmptyState extends UserFeedbackState {}
