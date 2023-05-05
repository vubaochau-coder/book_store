part of 'science_bloc.dart';

abstract class ScienceEvent extends Equatable {
  const ScienceEvent();

  @override
  List<Object> get props => [];
}

class ScicenceLoadEvent extends ScienceEvent {
  final int options;

  const ScicenceLoadEvent({required this.options});
}
