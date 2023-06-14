part of 'comic_bloc.dart';

abstract class ComicState extends Equatable {
  const ComicState();

  @override
  List<Object> get props => [];
}

class ComicLoadingState extends ComicState {}

class ComicLoadingSuccessfulState extends ComicState {
  final List<ShortProductDataModel> listComic;
  final int sortType;

  const ComicLoadingSuccessfulState({
    required this.listComic,
    required this.sortType,
  });
}
