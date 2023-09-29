import 'package:book_store/core/services/category_service.dart';

import '../models/short_protduct_data_model.dart';

class CategoryRepository {
  late CategoryService _service;

  CategoryRepository() {
    _service = CategoryService();
  }

  Future<List<ShortProductDataModel>> getBookingByType(String type) async {
    return await _service.getBookingByType(type);
  }
}
