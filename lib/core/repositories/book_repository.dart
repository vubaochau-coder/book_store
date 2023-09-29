import 'package:book_store/core/models/product_data_model.dart';
import 'package:book_store/core/services/book_service.dart';

class BookRepository {
  late BookService _service;

  BookRepository() {
    _service = BookService();
  }

  Future<void> increateTotalSold(String bookId, int count) async {
    return await _service.increateTotalSold(bookId, count);
  }

  Future<ProductDataModel> getBookInfo(String bookId) async {
    return await _service.getBookInfo(bookId);
  }
}
