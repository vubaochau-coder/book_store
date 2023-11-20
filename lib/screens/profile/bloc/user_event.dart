part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoadingEvent extends UserEvent {
  final bool firstTime;

  const UserLoadingEvent({required this.firstTime});
}

class StreamTransactionEvent extends UserEvent {}

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

  const UserUpdateEvent({
    required this.countZero,
    required this.countOne,
    required this.countTwo,
  });
}
