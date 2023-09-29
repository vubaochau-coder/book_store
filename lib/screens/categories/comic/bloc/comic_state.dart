part of 'comic_bloc.dart';

class ComicState extends Equatable {
  final List<ShortProductDataModel> listComic;
  final BookSortType sortType;
  final bool isLoading;

  const ComicState({
    this.listComic = const [],
    this.sortType = BookSortType.bestSale,
    this.isLoading = true,
  });

  @override
  List<Object> get props => [isLoading, listComic, sortType];

  ComicState copyWith({
    bool? isLoading,
    List<ShortProductDataModel>? listComic,
    BookSortType? sortType,
  }) {
    return ComicState(
      isLoading: isLoading ?? this.isLoading,
      listComic: listComic ?? this.listComic,
      sortType: sortType ?? this.sortType,
    );
  }
}
