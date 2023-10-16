import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/search_list_singleton.dart';
import 'package:book_store/core/models/search_suggestion_model.dart';
import 'package:book_store/core/models/short_protduct_data_model.dart';
import 'package:book_store/core/repositories/search_repository.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;

  SearchBloc(this._searchRepository) : super(const SearchState()) {
    on<SearchLoadingEvent>(_onLoading);
    on<SearchingEvent>(_onSearching);
    on<SearchRemoveEvent>(_onSearchRemove);
  }

  _onLoading(SearchLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    List<SearchSuggestionModel> recentSearch =
        await _searchRepository.getRecentSearch();

    emit(
      state.copyWith(searchedList: recentSearch, isLoading: false),
    );
  }

  _onSearching(SearchingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    if (event.isNewQuery) {
      await _searchRepository.addNewQuery(event.query);
    } else {
      await _searchRepository.updateQueryIndex(event.query);
    }

    String query = removeDiacritics(event.query.toLowerCase());

    SearchListSingleton dataList = SearchListSingleton();
    List<String> idResult = [];

    for (var data in dataList.dataList) {
      if (data.searchKey.contains(query)) {
        idResult.add(data.bookID);
      }
    }

    List<ShortProductDataModel> searchResult =
        await _searchRepository.getProductData(idResult);

    emit(SearchCompletedState(query: event.query, searchResult: searchResult));
  }

  _onSearchRemove(SearchRemoveEvent event, Emitter emit) async {
    await _searchRepository.removeSearch(event.idRemove);

    List<SearchSuggestionModel> recentSearch =
        await _searchRepository.getRecentSearch();

    emit(state.copyWith(searchedList: recentSearch));
  }
}
