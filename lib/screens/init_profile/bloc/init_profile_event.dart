part of 'init_profile_bloc.dart';

sealed class InitProfileEvent extends Equatable {
  const InitProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateNameEvent extends InitProfileEvent {
  final String name;

  const UpdateNameEvent({required this.name});
}

class UpdatePhoneEvent extends InitProfileEvent {
  final String phone;

  const UpdatePhoneEvent({required this.phone});
}

class UpdateBirthdayEvent extends InitProfileEvent {
  final DateTime birthday;

  const UpdateBirthdayEvent({required this.birthday});
}

class UpdateGenderEvent extends InitProfileEvent {
  final bool isMale;

  const UpdateGenderEvent({required this.isMale});
}

class SubmitEvent extends InitProfileEvent {}
