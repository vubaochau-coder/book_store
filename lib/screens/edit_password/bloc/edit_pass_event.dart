part of 'edit_pass_bloc.dart';

abstract class EditPasswordEvent extends Equatable {
  const EditPasswordEvent();

  @override
  List<Object> get props => [];
}

class EditPasswordLoadingEvent extends EditPasswordEvent {}

class EditPasswordUpdateEvent extends EditPasswordEvent {
  final String newPass;
  final String confirmNewPass;

  const EditPasswordUpdateEvent({
    required this.newPass,
    required this.confirmNewPass,
  });
}
