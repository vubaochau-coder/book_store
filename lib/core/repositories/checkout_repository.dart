import 'package:book_store/core/models/cart_item_model.dart';
import 'package:book_store/core/models/transport_model.dart';
import 'package:book_store/core/services/checkout_service.dart';

import '../models/transaction_model.dart';

class CheckoutRepository {
  late CheckoutService _service;

  CheckoutRepository() {
    _service = CheckoutService();
  }

  Future<List<TransportModel>> getTransports() async {
    return await _service.getTransports();
  }

  Future<String> createTransaction(TransactionModel transaction) async {
    return await _service.createTransaction(transaction);
  }

  Future<String> createTransaction2(TransactionModel transaction) async {
    return await _service.createTransaction2(transaction);
  }

  // Future<void> addProductToTransaction(
  //     List<CartItemModel> products, String transactionId) async {
  //   return await _service.addProductToTransaction(products, transactionId);
  // }

  Future<void> deleteItemFromCart(List<CartItemModel> products) async {
    return await _service.deleteItemFromCart(products);
  }

  Future<void> decreaseMultiProduct(List<CartItemModel> product) async {
    return _service.decreaseMultiProduct(product);
  }

  Future<bool> checkProductQuantity(List<CartItemModel> products) async {
    return _service.checkProductQuantity(products);
  }
}
