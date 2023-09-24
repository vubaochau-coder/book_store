part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool isLoading;
  final UserModel? userModel;
  final int zero;
  final int one;
  final int two;

  const UserState({
    this.isLoading = true,
    this.userModel,
    this.zero = 0,
    this.one = 0,
    this.two = 0,
  });

  @override
  List<Object?> get props => [isLoading, userModel, one, two, zero];

  UserState copyWith({
    bool? isLoading,
    UserModel? userModel,
    int? zero,
    int? one,
    int? two,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      userModel: userModel ?? this.userModel,
      one: one ?? this.one,
      two: two ?? this.two,
      zero: zero ?? this.zero,
    );
  }
}
