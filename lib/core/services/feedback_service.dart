import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:book_store/core/models/feedback_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackService {
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

  Future<List<FeedbackModel>> getAllFeedback(String bookId) async {
    List<FeedbackModel> res = [];
    final ref = FirebaseFirestore.instance
        .collection(FirebaseCollections.productFeedback);

    final limitFeedbackQuery = await ref
        .where('bookID', isEqualTo: bookId)
        .where('isHide', isEqualTo: false)
        .orderBy('dateSubmit', descending: true)
        .get();

    for (var ele in limitFeedbackQuery.docs) {
      res.add(FeedbackModel.fromSnaphot(ele));
    }

    return res;
  }

  Future<List<FeedbackModel>> getLimitFeedback(String bookId, int limit) async {
    List<FeedbackModel> res = [];
    final ref = FirebaseFirestore.instance
        .collection(FirebaseCollections.productFeedback);

    final limitFeedbackQuery = await ref
        .where('bookID', isEqualTo: bookId)
        .where('isHide', isEqualTo: false)
        .orderBy('dateSubmit', descending: true)
        .limit(limit)
        .get();

    for (var ele in limitFeedbackQuery.docs) {
      res.add(FeedbackModel.fromSnaphot(ele));
    }

    return res;
  }
}
