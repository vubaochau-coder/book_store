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
