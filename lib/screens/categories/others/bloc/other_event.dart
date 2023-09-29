part of 'other_bloc.dart';

abstract class OtherEvent extends Equatable {
  const OtherEvent();

  @override
  List<Object> get props => [];
}

class OtherLoadEvent extends OtherEvent {
  const OtherLoadEvent();
}

class UpdateSortTypeEvent extends OtherEvent {
  final BookSortType newType;

  const UpdateSortTypeEvent({required this.newType});
}
