part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {}

class UserLoadingSuccessfulState extends UserState {
  final UserModel userModel;

  const UserLoadingSuccessfulState({required this.userModel});
}

class UserLoadingFailedState extends UserState {
  final String error;

  const UserLoadingFailedState({required this.error});
}
