part of 'sgk_bloc.dart';

class SgkState extends Equatable {
  final List<ShortProductDataModel> listSGK;
  final BookSortType sortType;
  final bool isLoading;

  const SgkState({
    this.listSGK = const [],
    this.sortType = BookSortType.bestSale,
    this.isLoading = true,
  });

  @override
  List<Object> get props => [isLoading, listSGK, sortType];

  SgkState copyWith({
    bool? isLoading,
    List<ShortProductDataModel>? listSGK,
    BookSortType? sortType,
  }) {
    return SgkState(
      isLoading: isLoading ?? this.isLoading,
      listSGK: listSGK ?? this.listSGK,
      sortType: sortType ?? this.sortType,
    );
  }
}
