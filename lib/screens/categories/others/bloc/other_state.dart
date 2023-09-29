part of 'other_bloc.dart';

class OtherState extends Equatable {
  final List<ShortProductDataModel> listOther;
  final BookSortType sortType;
  final bool isLoading;

  const OtherState({
    this.listOther = const [],
    this.sortType = BookSortType.bestSale,
    this.isLoading = true,
  });

  @override
  List<Object> get props => [isLoading, listOther, sortType];

  OtherState copyWith({
    bool? isLoading,
    List<ShortProductDataModel>? listOther,
    BookSortType? sortType,
  }) {
    return OtherState(
      isLoading: isLoading ?? this.isLoading,
      listOther: listOther ?? this.listOther,
      sortType: sortType ?? this.sortType,
    );
  }
}
