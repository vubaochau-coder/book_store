import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/feedback_model.dart';
import 'package:book_store/core/models/product_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoadingState()) {
    on<ProductLoadingEvent>(productLoadingEvent);
    on<ProductFavoriteEvent>(productFavoriteEvent);
  }

  FutureOr<void> productLoadingEvent(
      ProductLoadingEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;
    bool isFavorited = false;
    List<FeedbackModel> feedbacks = [];
    int totalFeedback = 0;

    final bookDataQuery = await FirebaseFirestore.instance
        .collection('Book')
        .doc(event.idProduct)
        .get();

    ProductDataModel bookData = ProductDataModel.fromSnapshot(bookDataQuery);

    final allFeedbackQuery = await FirebaseFirestore.instance
        .collection('Feedback')
        .where('bookID', isEqualTo: event.idProduct)
        .get();

    if (allFeedbackQuery.docs.isNotEmpty) {
      totalFeedback = allFeedbackQuery.size;

      final feedbackQuery = await FirebaseFirestore.instance
          .collection('Feedback')
          .where('bookID', isEqualTo: event.idProduct)
          .orderBy('dateSubmit', descending: true)
          .limit(3)
          .get();

      for (var ele in feedbackQuery.docs) {
        feedbacks.add(FeedbackModel.fromSnaphot(ele));
      }
    }

    final checkFavoriteQuery = await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Favorite')
        .where('productID', isEqualTo: event.idProduct)
        .get();

    if (checkFavoriteQuery.docs.isNotEmpty) {
      isFavorited = true;
    }

    emit(ProductLoadingSuccesfulSatte(
      productData: bookData,
      isFavorited: isFavorited,
      feedbacks: feedbacks,
      totalFeedback: totalFeedback,
    ));
  }

  FutureOr<void> productFavoriteEvent(
      ProductFavoriteEvent event, Emitter<ProductState> emit) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final currentState = state as ProductLoadingSuccesfulSatte;

    final checkFavoriteQuery = await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Favorite')
        .where('productID', isEqualTo: event.idProduct)
        .get();

    if (checkFavoriteQuery.docs.isNotEmpty) {
      final docRef = FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('Favorite')
          .doc(checkFavoriteQuery.docs.first.id);

      await docRef.delete().then((value) {
        Fluttertoast.showToast(msg: 'Bỏ thích sản phẩm thành công');
        emit(ProductLoadingSuccesfulSatte(
          productData: currentState.productData,
          isFavorited: false,
          feedbacks: currentState.feedbacks,
          totalFeedback: currentState.totalFeedback,
        ));
      });
    } else {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('Favorite')
          .add({'productID': event.idProduct}).then((value) {
        Fluttertoast.showToast(msg: 'Đã Yêu thích sản phẩm');
        emit(ProductLoadingSuccesfulSatte(
          productData: currentState.productData,
          isFavorited: true,
          feedbacks: currentState.feedbacks,
          totalFeedback: currentState.totalFeedback,
        ));
      });
    }
  }
}
