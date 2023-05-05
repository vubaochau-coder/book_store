part of 'comic_bloc.dart';

abstract class ComicEvent extends Equatable {
  const ComicEvent();

  @override
  List<Object> get props => [];
}

class ComicLoadEvent extends ComicEvent {
  final int options;

  const ComicLoadEvent({required this.options});
}
