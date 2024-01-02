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
        .add(transaction.toJson(uid));

    return doc.id;
  }

  Future<String> createTransaction2(TransactionModel transaction) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection(FirebaseCollections.orders)
        .add(transaction.toJson(uid));

    return doc.id;
  }

  // Future<void> addProductToTransaction(
  //     List<CartItemModel> products, String transactionId) async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;

  //   await Future.wait([
  //     ...products.map((e) => FirebaseFirestore.instance
  //         .collection(FirebaseCollections.user)
  //         .doc(uid)
  //         .collection(FirebaseCollections.transaction)
  //         .doc(transactionId)
  //         .collection(FirebaseCollections.products)
  //         .add(e.toJson())),
  //   ]);
  // }

  Future<void> deleteItemFromCart(List<CartItemModel> products) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var batch = FirebaseFirestore.instance.batch();
    for (var ele in products) {
      batch.delete(FirebaseFirestore.instance
          .collection(FirebaseCollections.user)
          .doc(uid)
          .collection(FirebaseCollections.cart)
          .doc(ele.id));
    }
    await batch.commit();
    // await Future.wait(
    //   products.map((e) => FirebaseFirestore.instance
    //       .collection(FirebaseCollections.user)
    //       .doc(uid)
    //       .collection(FirebaseCollections.cart)
    //       .doc(e.id)
    //       .delete()),
    // );
  }

  Future<void> decreaseMultiProduct(List<CartItemModel> product) async {
    await Future.wait(product.map(
      (e) => decreaseProductStock(e.bookID, e.count),
    ));
  }

  Future<void> decreaseProductStock(String bookId, int count) async {
    var ref = FirebaseFirestore.instance
        .collection(FirebaseCollections.book)
        .doc(bookId);
    final query = await ref.get();
    int stock = query.get('stock');

    int newStock = stock - count;
    await ref.update(
      {
        'stock': newStock,
      },
    );
  }

  Future<bool> checkProductQuantity(List<CartItemModel> products) async {
    var ref = FirebaseFirestore.instance.collection(FirebaseCollections.book);

    bool check = true;
    for (var ele in products) {
      int checkoutQuantity = ele.count;

      final query = await ref.doc(ele.bookID).get();
      int stock = query.get('stock');
      if (checkoutQuantity > stock) {
        check = false;
        break;
      }
    }

    return check;
  }
}
