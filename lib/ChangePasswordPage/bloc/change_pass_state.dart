part of 'change_pass_bloc.dart';

abstract class ChangePassState extends Equatable {
  const ChangePassState();

  @override
  List<Object> get props => [];
}

class ChangePassLoadingState extends ChangePassState {}

class ChangePassGgFbState extends ChangePassState {}

class ChangePassLoadingSuccessfulState extends ChangePassState {
  final bool isLoading;
  final bool isConfirmErr;
  final String confirmErrMsg;

  const ChangePassLoadingSuccessfulState({
    required this.isLoading,
    required this.isConfirmErr,
    required this.confirmErrMsg,
  });

  @override
  List<Object> get props => [isLoading, isConfirmErr, confirmErrMsg];
}

class ChangePassSuccessfulState extends ChangePassState {}
