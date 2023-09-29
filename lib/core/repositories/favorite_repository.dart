import 'package:book_store/core/models/favorite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/favorite_service.dart';

class FavoriteRepository {
  late FavoriteService _service;

  FavoriteRepository() {
    _service = FavoriteService();
  }

  Future<bool> isBookFavorited(String bookId) async {
    return await _service.isBookFavorited(bookId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> favoriteStream() {
    return _service.favoriteStream();
  }

  Future<void> removeFavoriteBook(String favoriteId) async {
    return await _service.removeFavoriteBook(favoriteId);
  }

  Future<FavoriteModel> getFavoriteBook(String favoId, String bookId) async {
    return _service.getFavoriteBook(favoId, bookId);
  }
}
