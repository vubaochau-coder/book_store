part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainLoadingState extends MainState {}

class MainLoadingSuccessfulState extends MainState {
  final int cartNumber;
  final int messNumber;

  const MainLoadingSuccessfulState(
      {required this.cartNumber, required this.messNumber});

  @override
  List<Object> get props => [cartNumber, messNumber];
}
