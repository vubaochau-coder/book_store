part of 'feedback_count_bloc.dart';

abstract class FeedbackCountEvent extends Equatable {
  const FeedbackCountEvent();

  @override
  List<Object> get props => [];
}

class FeedbackCountLoadingEvent extends FeedbackCountEvent {}

class FeedbackCountUpdateEvent extends FeedbackCountEvent {
  final int updateTotal;

  const FeedbackCountUpdateEvent({required this.updateTotal});
}
