import '../models/search_suggestion_model.dart';
import '../models/short_protduct_data_model.dart';
import '../services/search_service.dart';

class SearchRepository {
  late SearchService _service;

  SearchRepository() {
    _service = SearchService();
  }

  Future<List<SearchSuggestionModel>> getRecentSearch() async {
    return _service.getRecentSearch();
  }

  Future<void> addNewQuery(String newQuery) async {
    return _service.addNewQuery(newQuery);
  }

  Future<void> updateQueryIndex(String query) async {
    return _service.updateQueryIndex(query);
  }

  Future<void> removeSearch(String searchId) async {
    return _service.removeSearch(searchId);
  }

  Future<List<ShortProductDataModel>> getProductData(
      List<String> productIds) async {
    return _service.getProductData(productIds);
  }
}
