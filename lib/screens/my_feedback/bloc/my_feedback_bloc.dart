import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/unfeedback_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'my_feedback_event.dart';
part 'my_feedback_state.dart';

class MyFeedbackBloc extends Bloc<MyFeedbackEvent, MyFeedbackState> {
  MyFeedbackBloc() : super(MyFeedbackLoadingState()) {
    on<MyFeedbackLoadingEvent>(feedbackLoadingEvent);
    on<MyFeedbackUpdateEvent>(feedbackUpdateEvent);
    on<MyFeedbackUpdateEmptyEvent>(feedbackUpdateEmptyEvent);
    on<MyFeedbackSubmitEvent>(feedbackSubmitEvent);
  }

  FutureOr<void> feedbackLoadingEvent(
      MyFeedbackLoadingEvent event, Emitter<MyFeedbackState> emit) async {
    emit(MyFeedbackLoadingState());

    final String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Feedback')
        .snapshots()
        .listen((snapshotEvent) {
      if (snapshotEvent.docs.isNotEmpty) {
        List<FeedbackItemModel> feedbacks = [];
        for (var ele in snapshotEvent.docs) {
          feedbacks.add(FeedbackItemModel.fromSnapshot(ele));
        }

        add(MyFeedbackUpdateEvent(
            newListFeedback: feedbacks, isLoading: false));
      } else {
        add(MyFeedbackUpdateEmptyEvent());
      }
    });
  }

  FutureOr<void> feedbackUpdateEvent(
      MyFeedbackUpdateEvent event, Emitter<MyFeedbackState> emit) {
    if (state is MyFeedbackLoadingState || state is MyFeedbackEmptyState) {
      emit(MyFeedbackLoadingSuccessfulState(
          listFeedback: event.newListFeedback, isLoading: event.isLoading));
    } else if (state is MyFeedbackLoadingSuccessfulState) {
      final currentState = state as MyFeedbackLoadingSuccessfulState;

      if (currentState.listFeedback.isNotEmpty) {
        currentState.listFeedback.clear();
      }

      emit(MyFeedbackLoadingSuccessfulState(
        listFeedback: event.newListFeedback,
        isLoading: event.isLoading,
      ));
    }
  }

  FutureOr<void> feedbackUpdateEmptyEvent(
      MyFeedbackUpdateEmptyEvent event, Emitter<MyFeedbackState> emit) {
    emit(MyFeedbackEmptyState());
  }

  FutureOr<void> feedbackSubmitEvent(
      MyFeedbackSubmitEvent event, Emitter<MyFeedbackState> emit) async {
    if (state is MyFeedbackLoadingSuccessfulState) {
      final currentState = state as MyFeedbackLoadingSuccessfulState;

      emit(MyFeedbackLoadingSuccessfulState(
        listFeedback: currentState.listFeedback,
        isLoading: true,
      ));

      String userName = FirebaseAuth.instance.currentUser!.displayName!;
      String imgUrl = FirebaseAuth.instance.currentUser!.photoURL!;
      final feedbackColRef = FirebaseFirestore.instance.collection('Feedback');

      await feedbackColRef.add({
        'bookID': event.bookID,
        'user': userName,
        'userImg': imgUrl,
        'dateSubmit': DateTime.now(),
        'rating': event.rating,
        'review': event.review,
      }).then((value) async {
        String uid = FirebaseAuth.instance.currentUser!.uid;

        await FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Feedback')
            .doc(event.feedbackID)
            .delete()
            .then((value) {
          Fluttertoast.showToast(msg: 'Cảm ơn bạn đã đánh giá sản phẩm');
        });
      });
    }
  }
}
