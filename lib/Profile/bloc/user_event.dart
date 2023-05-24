part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoadingEvent extends UserEvent {}

class UserUpdateProfileEvent extends UserEvent {
  final String name;
  final String img;
  final String uid;

  const UserUpdateProfileEvent(
      {required this.name, required this.img, required this.uid});
}

class UserUpdateEvent extends UserEvent {
  final int countZero;
  final int countOne;
  final int countTwo;
  final int countThree;
  final UserModel model;

  const UserUpdateEvent({
    required this.countZero,
    required this.countOne,
    required this.countTwo,
    required this.countThree,
    required this.model,
  });
}
