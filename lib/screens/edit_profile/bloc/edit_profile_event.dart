part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileLoadingEvent extends EditProfileEvent {}

class EditProfileChangingEvent extends EditProfileEvent {
  final File? image;
  final String name;
  final String phone;
  final bool gender;
  final String birthday;

  const EditProfileChangingEvent({
    required this.image,
    required this.name,
    required this.phone,
    required this.gender,
    required this.birthday,
  });
}
