part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileLoadingSuccessfulState extends EditProfileState {
  final String avtURL;
  final String name;
  final String phone;
  final bool isMale;
  final String birthday;
  final bool isLoading;

  const EditProfileLoadingSuccessfulState({
    required this.avtURL,
    required this.name,
    required this.phone,
    required this.isMale,
    required this.birthday,
    required this.isLoading,
  });

  @override
  List<Object> get props => [
        avtURL,
        name,
        phone,
        isMale,
        birthday,
        isLoading,
      ];
}

class EditProfileNavigateState extends EditProfileState {}
