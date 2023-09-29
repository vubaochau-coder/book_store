part of 'child_bloc.dart';

abstract class ChildEvent extends Equatable {
  const ChildEvent();

  @override
  List<Object> get props => [];
}

class ChildLoadEvent extends ChildEvent {
  const ChildLoadEvent();
}

class UpdateSortTypeEvent extends ChildEvent {
  final BookSortType newType;

  const UpdateSortTypeEvent({required this.newType});
}
