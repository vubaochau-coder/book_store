part of 'feedback_count_bloc.dart';

abstract class FeedbackCountState extends Equatable {
  const FeedbackCountState();

  @override
  List<Object> get props => [];
}

class FeedbackCountLoadingState extends FeedbackCountState {}

class FeedbackCountLoadedState extends FeedbackCountState {
  final int totalFeedback;

  const FeedbackCountLoadedState({required this.totalFeedback});

  @override
  List<Object> get props => [totalFeedback];
}
