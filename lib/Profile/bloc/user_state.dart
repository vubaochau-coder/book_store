part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {}

class UserLoadingSuccessfulState extends UserState {
  final UserModel userModel;
  final int zero;
  final int one;
  final int two;
  final int three;

  const UserLoadingSuccessfulState({
    required this.zero,
    required this.one,
    required this.two,
    required this.three,
    required this.userModel,
  });

  @override
  List<Object> get props => [zero, one, two, three, userModel];
}

class UserLoadingFailedState extends UserState {
  final String error;

  const UserLoadingFailedState({required this.error});
}
