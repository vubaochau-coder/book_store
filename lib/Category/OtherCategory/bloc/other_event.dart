part of 'other_bloc.dart';

abstract class OtherEvent extends Equatable {
  const OtherEvent();

  @override
  List<Object> get props => [];
}

class OtherLoadEvent extends OtherEvent {
  final int options;

  const OtherLoadEvent({required this.options});
}
