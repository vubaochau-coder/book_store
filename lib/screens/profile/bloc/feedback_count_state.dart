part of 'feedback_count_bloc.dart';

class FeedbackCountState extends Equatable {
  final bool isLoading;
  final int totalFeedback;

  const FeedbackCountState({
    this.isLoading = true,
    this.totalFeedback = 0,
  });

  @override
  List<Object> get props => [isLoading, totalFeedback];

  FeedbackCountState copyWith({bool? isLoading, int? totalFeedback}) {
    return FeedbackCountState(
      isLoading: isLoading ?? this.isLoading,
      totalFeedback: totalFeedback ?? this.totalFeedback,
    );
  }
}
