part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final bool isLoading;
  final String avtURL;
  final String name;
  final String phone;
  final bool isMale;
  final String birthday;
  final bool showDialogLoading;
  final File? newAvatar;

  final bool isNameErr;
  final bool isPhoneErr;
  final bool isBirthdayErr;

  const EditProfileState({
    this.isLoading = true,
    this.avtURL = '',
    this.name = '',
    this.phone = '',
    this.isMale = true,
    this.birthday = '',
    this.showDialogLoading = false,
    this.isNameErr = false,
    this.isPhoneErr = false,
    this.isBirthdayErr = false,
    this.newAvatar,
  });

  @override
  List<Object?> get props => [
        isLoading,
        avtURL,
        name,
        phone,
        isMale,
        birthday,
        showDialogLoading,
        isNameErr,
        isPhoneErr,
        isBirthdayErr,
        newAvatar,
      ];

  EditProfileState copyWith({
    bool? isLoading,
    String? avtURL,
    String? name,
    String? phone,
    bool? isMale,
    String? birthday,
    bool? showDialogLoading,
    bool? isNameErr,
    bool? isPhoneErr,
    bool? isBirthdayErr,
    File? newAvatar,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      avtURL: avtURL ?? this.avtURL,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      isMale: isMale ?? this.isMale,
      birthday: birthday ?? this.birthday,
      showDialogLoading: showDialogLoading ?? this.showDialogLoading,
      isNameErr: isNameErr ?? this.isNameErr,
      isPhoneErr: isPhoneErr ?? this.isPhoneErr,
      isBirthdayErr: isBirthdayErr ?? this.isBirthdayErr,
      newAvatar: newAvatar ?? this.newAvatar,
    );
  }
}

class EditProfileNavigateState extends EditProfileState {}
