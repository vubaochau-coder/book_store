import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cart_item_model.dart';
import '../services/transaction_service.dart';

class TransactionRepository {
  late TransactionService _service;

  TransactionRepository() {
    _service = TransactionService();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> transactionStream(
      List<int> status) {
    return _service.transactionStream(status);
  }

  Future<List<CartItemModel>> getAllProductOfTransaction(String transId) async {
    return await _service.getAllProductOfTransaction(transId);
  }

  Future<void> cancelTransaction(String transId) async {
    return await _service.cancelTransaction(transId);
  }

  Future<void> receiveTransaction(String transId) async {
    return await _service.receiveTransaction(transId);
  }

  Future<Map<String, dynamic>> getOrderProduct(String productId) async {
    return _service.getOrderProduct(productId);
  }
}
