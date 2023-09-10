part of 'my_feedback_bloc.dart';

class MyFeedbackState extends Equatable {
  final List<FeedbackItemModel> listFeedback;
  final bool isLoading;
  final bool showLoadingDialog;

  const MyFeedbackState({
    this.listFeedback = const [],
    this.isLoading = false,
    this.showLoadingDialog = false,
  });

  @override
  List<Object> get props => [listFeedback, isLoading, showLoadingDialog];

  MyFeedbackState copyWith(
      {bool? isLoading,
      bool? showLoadingDialog,
      List<FeedbackItemModel>? listFeedback}) {
    return MyFeedbackState(
      isLoading: isLoading ?? this.isLoading,
      showLoadingDialog: showLoadingDialog ?? this.showLoadingDialog,
      listFeedback: listFeedback ?? this.listFeedback,
    );
  }
}
