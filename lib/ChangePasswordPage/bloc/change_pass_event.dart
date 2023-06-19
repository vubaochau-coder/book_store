part of 'change_pass_bloc.dart';

abstract class ChangePassEvent extends Equatable {
  const ChangePassEvent();

  @override
  List<Object> get props => [];
}

class ChangePassLoadingEvent extends ChangePassEvent {}

class ChangePassUpdatePassEvent extends ChangePassEvent {
  final String newPass;
  final String confirmNewPass;

  const ChangePassUpdatePassEvent({
    required this.newPass,
    required this.confirmNewPass,
  });
}
