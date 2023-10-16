import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cart_item_model.dart';
import '../services/cart_service.dart';

class CartRepository {
  late CartService _service;

  CartRepository() {
    _service = CartService();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartStream() {
    return _service.cartStream();
  }

  Future<CartItemModel> getBook(
      QueryDocumentSnapshot<Map<String, dynamic>> e) async {
    return _service.getBook(e);
  }

  Future<void> removeItemFromCart(String cartItemId) async {
    return await _service.removeItemFromCart(cartItemId);
  }

  Future<void> addItemToCart(String bookId) async {
    return await _service.addItemToCart(bookId);
  }
}
