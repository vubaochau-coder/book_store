import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/feedback_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'product_feedback_event.dart';
part 'product_feedback_state.dart';

class ProductFeedbackBloc
    extends Bloc<ProductFeedbackEvent, ProductFeedbackState> {
  ProductFeedbackBloc() : super(ProductFeedbackLoadingState()) {
    on<ProductFeedbackLoadingEvent>(productFeedbackLoadingEvent);
  }

  FutureOr<void> productFeedbackLoadingEvent(ProductFeedbackLoadingEvent event,
      Emitter<ProductFeedbackState> emit) async {
    emit(ProductFeedbackLoadingState());

    List<FeedbackModel> feedbacks = [];

    if (event.sortOption == 0) {
      final feedbackQuery = await FirebaseFirestore.instance
          .collection('Feedback')
          .where('bookID', isEqualTo: event.bookID)
          .orderBy('dateSubmit', descending: true)
          .get();

      for (var ele in feedbackQuery.docs) {
        feedbacks.add(FeedbackModel.fromSnaphot(ele));
      }
    } else {
      final feedbackQuery = await FirebaseFirestore.instance
          .collection('Feedback')
          .where('bookID', isEqualTo: event.bookID)
          .where('rating', isEqualTo: event.sortOption)
          .orderBy('dateSubmit', descending: true)
          .get();

      for (var ele in feedbackQuery.docs) {
        feedbacks.add(FeedbackModel.fromSnaphot(ele));
      }
    }

    emit(ProductFeedbackLoadedState(
        sortType: event.sortOption, feedbacks: feedbacks));
  }
}
