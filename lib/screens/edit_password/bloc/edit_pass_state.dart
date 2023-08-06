part of 'edit_pass_bloc.dart';

abstract class EditPasswordState extends Equatable {
  const EditPasswordState();

  @override
  List<Object> get props => [];
}

class EditPasswordLoadingState extends EditPasswordState {}

class EditPassGgFbState extends EditPasswordState {}

class EditPassLoadingSuccessfulState extends EditPasswordState {
  final bool isLoading;
  final bool isConfirmErr;
  final String confirmErrMsg;

  const EditPassLoadingSuccessfulState({
    required this.isLoading,
    required this.isConfirmErr,
    required this.confirmErrMsg,
  });

  @override
  List<Object> get props => [isLoading, isConfirmErr, confirmErrMsg];
}

class ChangePassSuccessfulState extends EditPasswordState {}
