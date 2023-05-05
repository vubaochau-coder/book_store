part of 'child_bloc.dart';

abstract class ChildEvent extends Equatable {
  const ChildEvent();

  @override
  List<Object> get props => [];
}

class ChildLoadEvent extends ChildEvent {
  final int options;

  const ChildLoadEvent({required this.options});
}
