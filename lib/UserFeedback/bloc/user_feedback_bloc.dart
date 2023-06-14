import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/unfeedback_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'user_feedback_event.dart';
part 'user_feedback_state.dart';

class UserFeedbackBloc extends Bloc<UserFeedbackEvent, UserFeedbackState> {
  UserFeedbackBloc() : super(UserFeedbackLoadingState()) {
    on<UserFeedbackLoadingEvent>(feedbackLoadingEvent);
    on<UserFeedbackUpdateEvent>(feedbackUpdateEvent);
    on<UserFeedbackUpdateEmptyEvent>(feedbackUpdateEmptyEvent);
    on<UserFeedbackSubmitEvent>(feedbackSubmitEvent);
  }

  FutureOr<void> feedbackLoadingEvent(
      UserFeedbackLoadingEvent event, Emitter<UserFeedbackState> emit) async {
    emit(UserFeedbackLoadingState());

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

        add(UserFeedbackUpdateEvent(
            newListFeedback: feedbacks, isLoading: false));
      } else {
        add(UserFeedbackUpdateEmptyEvent());
      }
    });
  }

  FutureOr<void> feedbackUpdateEvent(
      UserFeedbackUpdateEvent event, Emitter<UserFeedbackState> emit) {
    if (state is UserFeedbackLoadingState || state is UserFeedbackEmptyState) {
      emit(UserFeedbackLoadingSuccessfulState(
          listFeedback: event.newListFeedback, isLoading: event.isLoading));
    } else if (state is UserFeedbackLoadingSuccessfulState) {
      final currentState = state as UserFeedbackLoadingSuccessfulState;

      if (currentState.listFeedback.isNotEmpty) {
        currentState.listFeedback.clear();
      }

      emit(UserFeedbackLoadingSuccessfulState(
        listFeedback: event.newListFeedback,
        isLoading: event.isLoading,
      ));
    }
  }

  FutureOr<void> feedbackUpdateEmptyEvent(
      UserFeedbackUpdateEmptyEvent event, Emitter<UserFeedbackState> emit) {
    emit(UserFeedbackEmptyState());
  }

  FutureOr<void> feedbackSubmitEvent(
      UserFeedbackSubmitEvent event, Emitter<UserFeedbackState> emit) async {
    if (state is UserFeedbackLoadingSuccessfulState) {
      final currentState = state as UserFeedbackLoadingSuccessfulState;

      emit(UserFeedbackLoadingSuccessfulState(
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
