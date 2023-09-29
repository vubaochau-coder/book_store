import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:book_store/core/models/favorite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteService {
  Future<bool> isBookFavorited(String bookId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final query = await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.favorite)
        .where('productID', isEqualTo: bookId)
        .get();
    return query.docs.isNotEmpty;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> favoriteStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.favorite)
        .snapshots();
  }

  Future<void> addFavoriteBook(String bookId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.favorite)
        .add({'productID': bookId});
  }

  Future<void> unFavoriteByBookId(String bookId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final docs = await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.favorite)
        .where('productID', isEqualTo: bookId)
        .get();
    await Future.wait([
      ...docs.docs.map(
        (e) => e.reference.delete(),
      )
    ]);
  }

  Future<void> unFavoriteByFavoriteId(String favoriteId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.favorite)
        .doc(favoriteId);
    await docRef.delete();
  }

  Future<FavoriteModel> getFavoriteBook(
      String favoriteId, String bookId) async {
    final productQuery = await FirebaseFirestore.instance
        .collection(FirebaseCollections.book)
        .doc(bookId)
        .get();
    String bookTitle = productQuery.data()!['title'] ?? 'None title';
    String bookURL = List.from(productQuery.data()!['listURL'])[0];
    double bookPrice = productQuery.data()!['price'] ?? 0;
    double discount = productQuery.data()!['discount'] ?? 0;

    return FavoriteModel(
      id: favoriteId,
      productID: bookId,
      productTitle: bookTitle,
      imgURL: bookURL,
      price: bookPrice * (1 - discount),
    );
  }
}
