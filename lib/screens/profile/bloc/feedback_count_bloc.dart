import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'feedback_count_event.dart';
part 'feedback_count_state.dart';

class FeedbackCountBloc extends Bloc<FeedbackCountEvent, FeedbackCountState> {
  FeedbackCountBloc() : super(FeedbackCountLoadingState()) {
    on<FeedbackCountLoadingEvent>(feedbackCountLoadingEvent);
    on<FeedbackCountUpdateEvent>(feedbackCountUpdateEvent);
  }

  FutureOr<void> feedbackCountLoadingEvent(
      FeedbackCountLoadingEvent event, Emitter<FeedbackCountState> emit) {
    emit(FeedbackCountLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Feedback')
        .snapshots()
        .listen((event) async {
      int total = event.docs.length;

      add(FeedbackCountUpdateEvent(updateTotal: total));
    });
  }

  FutureOr<void> feedbackCountUpdateEvent(
      FeedbackCountUpdateEvent event, Emitter<FeedbackCountState> emit) {
    emit(FeedbackCountLoadedState(totalFeedback: event.updateTotal));
  }
}
