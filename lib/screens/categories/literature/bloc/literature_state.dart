part of 'literature_bloc.dart';

class LiteratureState extends Equatable {
  final List<ShortProductDataModel> listLiterature;
  final BookSortType sortType;
  final bool isLoading;

  const LiteratureState({
    this.listLiterature = const [],
    this.sortType = BookSortType.bestSale,
    this.isLoading = true,
  });

  @override
  List<Object> get props => [isLoading, listLiterature, sortType];

  LiteratureState copyWith({
    bool? isLoading,
    List<ShortProductDataModel>? listLiterature,
    BookSortType? sortType,
  }) {
    return LiteratureState(
      isLoading: isLoading ?? this.isLoading,
      listLiterature: listLiterature ?? this.listLiterature,
      sortType: sortType ?? this.sortType,
    );
  }
}
