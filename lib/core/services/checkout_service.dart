import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart_item_model.dart';
import '../models/transaction_model.dart';
import '../models/transport_model.dart';

class CheckoutService {
  Future<List<TransportModel>> getTransports() async {
    List<TransportModel> res = [];
    final transportQuery = await FirebaseFirestore.instance
        .collection(FirebaseCollections.transport)
        .get();
    for (int i = 0; i < transportQuery.size; i++) {
      res.add(TransportModel.fromSnapshot(transportQuery.docs[i], i == 0));
    }
    return res;
  }

  Future<String> createTransaction(TransactionModel transaction) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.transaction)
        .add(transaction.toJson());

    return doc.id;
  }

  Future<void> addProductToTransaction(
      List<CartItemModel> products, String transactionId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await Future.wait([
      ...products.map((e) => FirebaseFirestore.instance
          .collection(FirebaseCollections.user)
          .doc(uid)
          .collection(FirebaseCollections.transaction)
          .doc(transactionId)
          .collection(FirebaseCollections.products)
          .add(e.toJson())),
    ]);
  }

  Future<void> deleteItemFromCart(List<CartItemModel> products) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await Future.wait(
      products.map((e) => FirebaseFirestore.instance
          .collection(FirebaseCollections.user)
          .doc(uid)
          .collection(FirebaseCollections.cart)
          .doc(e.id)
          .delete()),
    );
  }
}
