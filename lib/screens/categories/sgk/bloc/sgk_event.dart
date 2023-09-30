part of 'sgk_bloc.dart';

abstract class SgkEvent extends Equatable {
  const SgkEvent();

  @override
  List<Object> get props => [];
}

class SgkLoadEvent extends SgkEvent {
  const SgkLoadEvent();
}

class UpdateSortTypeEvent extends SgkEvent {
  final BookSortType newType;

  const UpdateSortTypeEvent({required this.newType});
}
