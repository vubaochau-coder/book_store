import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:book_store/core/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  Stream<QuerySnapshot<Map<String, dynamic>>> cartStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.cart)
        .snapshots();
  }

  Future<CartItemModel> getBook(
      QueryDocumentSnapshot<Map<String, dynamic>> e) async {
    String bookId = e.data()['productID'];

    final bookQuery = await FirebaseFirestore.instance
        .collection(FirebaseCollections.book)
        .doc(bookId)
        .get();

    String bookTitle = bookQuery.get('title');
    double bookPrice = double.parse(bookQuery.get('price').toString());
    double bookDiscount = double.parse(bookQuery.get('discount').toString());
    String url = List.from(bookQuery.get('listURL'))[0];

    return CartItemModel.fromSnapshot(
      e,
      (bookPrice - bookPrice * bookDiscount),
      bookPrice,
      url,
      bookTitle,
    );
  }

  Future<void> removeItemFromCart(String cartItemId) async {
    final String userID = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(userID)
        .collection(FirebaseCollections.cart)
        .doc(cartItemId);
    await docRef.delete();
  }

  Future<void> addItemToCart(String bookId) async {
    bool check = await isBookAlreadyInCart(bookId);
    if (!check) {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.user)
          .doc(userID)
          .collection(FirebaseCollections.cart)
          .add({
        'productID': bookId,
        'count': 1,
      });
    }
  }

  Future<bool> isBookAlreadyInCart(String bookId) async {
    final String userID = FirebaseAuth.instance.currentUser!.uid;
    final docRef = await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(userID)
        .collection(FirebaseCollections.cart)
        .where('productID', isEqualTo: bookId)
        .get();
    return docRef.size > 0;
  }
}
