part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileLoadingEvent extends EditProfileEvent {}

class EditProfileChangingEvent extends EditProfileEvent {
  const EditProfileChangingEvent();
}

class UpdateGenderEvent extends EditProfileEvent {
  final bool isMale;

  const UpdateGenderEvent({required this.isMale});
}

class UpdateBirthdayEvent extends EditProfileEvent {
  final String birthday;

  const UpdateBirthdayEvent({required this.birthday});
}

class UpdateNameEvent extends EditProfileEvent {
  final String name;

  const UpdateNameEvent({required this.name});
}

class UpdatePhoneEvent extends EditProfileEvent {
  final String phone;

  const UpdatePhoneEvent({required this.phone});
}

class UpdateAvatarEvent extends EditProfileEvent {
  final File avatar;

  const UpdateAvatarEvent({required this.avatar});
}
