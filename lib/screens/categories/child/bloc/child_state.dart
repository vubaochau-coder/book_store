part of 'child_bloc.dart';

class ChildState extends Equatable {
  final bool isLoading;
  final List<ShortProductDataModel> listChild;
  final BookSortType sortType;

  const ChildState({
    this.listChild = const [],
    this.sortType = BookSortType.bestSale,
    this.isLoading = true,
  });

  @override
  List<Object> get props => [isLoading, listChild, sortType];

  ChildState copyWith({
    bool? isLoading,
    List<ShortProductDataModel>? listChild,
    BookSortType? sortType,
  }) {
    return ChildState(
      isLoading: isLoading ?? this.isLoading,
      listChild: listChild ?? this.listChild,
      sortType: sortType ?? this.sortType,
    );
  }
}
