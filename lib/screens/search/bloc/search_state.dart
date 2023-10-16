part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool isLoading;
  final List<SearchSuggestionModel> searchedList;

  const SearchState({
    this.isLoading = true,
    this.searchedList = const [],
  });

  @override
  List<Object> get props => [isLoading, searchedList];

  SearchState copyWith({
    bool? isLoading,
    List<SearchSuggestionModel>? searchedList,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      searchedList: searchedList ?? this.searchedList,
    );
  }
}

class SearchCompletedState extends SearchState {
  final String query;
  final List<ShortProductDataModel> searchResult;

  const SearchCompletedState({required this.query, required this.searchResult});
}
