import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'feedback_count_event.dart';
part 'feedback_count_state.dart';

class FeedbackCountBloc extends Bloc<FeedbackCountEvent, FeedbackCountState> {
  StreamSubscription? _feedbackStream;

  FeedbackCountBloc() : super(const FeedbackCountState()) {
    on<FeedbackCountLoadingEvent>(_onLoading);
    on<FeedbackCountUpdateEvent>(_onUpdate);
  }

  @override
  Future<void> close() async {
    _feedbackStream?.cancel();
    _feedbackStream = null;
    super.close();
  }

  _onLoading(FeedbackCountLoadingEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: true));

    String uid = FirebaseAuth.instance.currentUser!.uid;

    _feedbackStream = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Feedback')
        .snapshots()
        .listen((event) async {
      int total = event.docs.length;

      add(FeedbackCountUpdateEvent(updateTotal: total));
    });
  }

  FutureOr<void> _onUpdate(
      FeedbackCountUpdateEvent event, Emitter<FeedbackCountState> emit) {
    emit(
      state.copyWith(
        isLoading: false,
        totalFeedback: event.updateTotal,
      ),
    );
  }
}
