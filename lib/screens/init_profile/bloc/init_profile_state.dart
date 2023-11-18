part of 'init_profile_bloc.dart';

class InitProfileState extends Equatable {
  final String name;
  final String phone;
  final DateTime? birthday;
  final bool isMale;
  final String errName;
  final String errPhone;
  final String errBirthday;

  const InitProfileState({
    this.name = "",
    this.phone = "",
    this.birthday,
    this.isMale = true,
    this.errName = "",
    this.errPhone = "",
    this.errBirthday = "",
  });

  @override
  List<Object?> get props =>
      [name, phone, birthday, isMale, errName, errPhone, errBirthday];

  InitProfileState copyWith({
    String? name,
    String? phone,
    DateTime? birthday,
    bool? isMale,
    String? errName,
    String? errPhone,
    String? errBirthday,
  }) {
    return InitProfileState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      isMale: isMale ?? this.isMale,
      errName: errName ?? this.errName,
      errPhone: errPhone ?? this.errPhone,
      errBirthday: errBirthday ?? this.errBirthday,
    );
  }
}
