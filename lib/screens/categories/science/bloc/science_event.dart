part of 'science_bloc.dart';

abstract class ScienceEvent extends Equatable {
  const ScienceEvent();

  @override
  List<Object> get props => [];
}

class ScicenceLoadEvent extends ScienceEvent {
  const ScicenceLoadEvent();
}

class UpdateSortTypeEvent extends ScienceEvent {
  final BookSortType newType;

  const UpdateSortTypeEvent({required this.newType});
}
