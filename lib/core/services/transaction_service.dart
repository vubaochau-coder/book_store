import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:book_store/core/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  Stream<QuerySnapshot<Map<String, dynamic>>> transactionStream(int status) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection(FirebaseCollections.orders)
        .where('status', isEqualTo: status)
        .where('userId', isEqualTo: uid)
        .snapshots();

    // return FirebaseFirestore.instance
    //     .collection(FirebaseCollections.user)
    //     .doc(uid)
    //     .collection(FirebaseCollections.transaction)
    //     .where('status', isEqualTo: status)
    //     .snapshots();
  }

  Future<List<CartItemModel>> getAllProductOfTransaction(String transId) async {
    List<CartItemModel> products = [];
    // final String uid = FirebaseAuth.instance.currentUser!.uid;

    // final productsQuery = await FirebaseFirestore.instance
    //     .collection(FirebaseCollections.user)
    //     .doc(uid)
    //     .collection(FirebaseCollections.transaction)
    //     .doc(transId)
    //     .collection(FirebaseCollections.products)
    //     .get();

    final productsQuery = await FirebaseFirestore.instance
        .collection(FirebaseCollections.orders)
        .doc(transId)
        .get();

    List<Map<String, dynamic>> rawPrs =
        List.from(productsQuery.data()!['products']);

    List<String> productIds = [];

    // for (var tempEle in productsQuery.docs) {
    //   String bookID = tempEle.get('productID');
    //   productIds.add(bookID);
    // }

    for (var tempEle in rawPrs) {
      String bookID = tempEle['productID'];
      productIds.add(bookID);
    }

    final futureGroup = await Future.wait(
      productIds.map(
        (e) => FirebaseFirestore.instance
            .collection(FirebaseCollections.book)
            .doc(e)
            .get(),
      ),
    );

    for (int i = 0; i < productIds.length; i++) {
      String bookTitle = futureGroup[i].get('title');
      double bookPrice = double.parse(rawPrs[i]['price'].toString());
      // double bookPrice = double.parse(
      //     productsQuery.docs[i].get('priceBeforeDiscount').toString());
      double bookPriceBeforeDiscount =
          double.parse(rawPrs[i]['priceBeforeDiscount'].toString());
      // double bookDiscount = 1 -
      //     double.parse(productsQuery.docs[i].get('price').toString()) /
      //         double.parse(
      //             productsQuery.docs[i].get('priceBeforeDiscount').toString());
      String url = futureGroup[i].get('mainURL');
      // String url = List.from(futureGroup[i].get('listURL'))[0];

      products.add(
        CartItemModel(
          id: '',
          bookID: rawPrs[i]['productID'],
          count: rawPrs[i]['count'],
          price: bookPrice,
          imgUrl: url,
          title: bookTitle,
          priceBeforeDiscount: bookPriceBeforeDiscount,
        ),
        // CartItemModel.fromSnapshot(
        //   productsQuery.docs[i],
        //   (bookPrice * (1 - bookDiscount)),
        //   bookPrice,
        //   url,
        //   bookTitle,
        // ),
      );
    }
    return products;
  }

  Future<void> cancelTransaction(String transId) async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;

    final docRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.orders)
        .doc(transId);

    // final docRef = FirebaseFirestore.instance
    //     .collection(FirebaseCollections.user)
    //     .doc(uid)
    //     .collection(FirebaseCollections.transaction)
    //     .doc(transId);

    await docRef.update({'status': -1});
  }

  Future<void> receiveTransaction(String transId) async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;

    final docRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.orders)
        .doc(transId);

    // final docRef = FirebaseFirestore.instance
    //     .collection(FirebaseCollections.user)
    //     .doc(uid)
    //     .collection(FirebaseCollections.transaction)
    //     .doc(transId);

    await docRef.update({
      'dateCompleted': DateTime.now(),
      'status': 3,
    });
  }

  Future<Map<String, dynamic>> getOrderProduct(String productId) async {
    final query = await FirebaseFirestore.instance
        .collection(FirebaseCollections.book)
        .doc(productId)
        .get();
    String productName = query.data()?['title'];
    String imgURL = query.data()?['mainURL'];
    return {
      'productId': productId,
      'productName': productName,
      'imgURL': imgURL,
    };
  }
}
