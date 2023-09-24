import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyFeedbackService {
  Future<void> addNewFeedback(
      String bookId, String bookTitle, double price, String img) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final feedbackCollection = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.myFeedback);
    await feedbackCollection.add({
      'productID': bookId,
      'price': price,
      'bookTitle': bookTitle,
      'imgURL': img,
    });
  }
}
