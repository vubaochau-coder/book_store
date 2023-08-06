part of 'my_feedback_bloc.dart';

abstract class MyFeedbackState extends Equatable {
  const MyFeedbackState();

  @override
  List<Object> get props => [];
}

class MyFeedbackLoadingState extends MyFeedbackState {}

class MyFeedbackLoadingSuccessfulState extends MyFeedbackState {
  final List<FeedbackItemModel> listFeedback;
  final bool isLoading;

  const MyFeedbackLoadingSuccessfulState({
    required this.listFeedback,
    required this.isLoading,
  });

  @override
  List<Object> get props => [listFeedback, isLoading];
}

class MyFeedbackEmptyState extends MyFeedbackState {}
