part of 'comic_bloc.dart';

abstract class ComicEvent extends Equatable {
  const ComicEvent();

  @override
  List<Object> get props => [];
}

class ComicLoadEvent extends ComicEvent {
  const ComicLoadEvent();
}

class UpdateSortTypeEvent extends ComicEvent {
  final BookSortType newType;

  const UpdateSortTypeEvent({required this.newType});
}
