part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {}

class SearchLoadingSuccessfulState extends SearchState {
  final List<SearchSuggestionModel> searchedList;

  const SearchLoadingSuccessfulState({required this.searchedList});

  @override
  List<Object> get props => [searchedList];
}

class SearchLoadingEmptyState extends SearchState {}

class SearchCompletedState extends SearchState {
  final String query;
  final List<ShortProductDataModel> searchResult;

  const SearchCompletedState({required this.query, required this.searchResult});
}
