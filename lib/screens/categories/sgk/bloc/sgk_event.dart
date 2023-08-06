part of 'sgk_bloc.dart';

abstract class SgkEvent extends Equatable {
  const SgkEvent();

  @override
  List<Object> get props => [];
}

class SgkLoadEvent extends SgkEvent {
  final int options;

  const SgkLoadEvent({required this.options});
}
