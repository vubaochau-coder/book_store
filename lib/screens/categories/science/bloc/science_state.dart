part of 'science_bloc.dart';

class ScienceState extends Equatable {
  final List<ShortProductDataModel> listScience;
  final BookSortType sortType;
  final bool isLoading;

  const ScienceState({
    this.listScience = const [],
    this.sortType = BookSortType.bestSale,
    this.isLoading = true,
  });

  @override
  List<Object> get props => [isLoading, listScience, sortType];

  ScienceState copyWith({
    bool? isLoading,
    List<ShortProductDataModel>? listScience,
    BookSortType? sortType,
  }) {
    return ScienceState(
      isLoading: isLoading ?? this.isLoading,
      listScience: listScience ?? this.listScience,
      sortType: sortType ?? this.sortType,
    );
  }
}
