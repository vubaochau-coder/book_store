import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:book_store/core/models/unfeedback_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'my_feedback_event.dart';
part 'my_feedback_state.dart';

class MyFeedbackBloc extends Bloc<MyFeedbackEvent, MyFeedbackState> {
  StreamSubscription? _feedbackStream;

  MyFeedbackBloc() : super(const MyFeedbackState()) {
    on<MyFeedbackLoadingEvent>(_onLoading);
    on<MyFeedbackUpdateEvent>(_onUpdate);
    on<MyFeedbackUpdateEmptyEvent>(_onUpdateEmpty);
    on<MyFeedbackSubmitEvent>(_onSubmitFeedback);
  }

  @override
  Future<void> close() async {
    _feedbackStream?.cancel();
    _feedbackStream = null;
    super.close();
  }

  _onLoading(MyFeedbackLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    final String uid = FirebaseAuth.instance.currentUser!.uid;

    _feedbackStream = FirebaseFirestore.instance
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

        add(MyFeedbackUpdateEvent(newListFeedback: feedbacks));
      } else {
        add(MyFeedbackUpdateEmptyEvent());
      }
    });
  }

  _onUpdate(MyFeedbackUpdateEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: false, listFeedback: event.newListFeedback));
  }

  _onUpdateEmpty(MyFeedbackUpdateEmptyEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: false, listFeedback: []));
  }

  _onSubmitFeedback(MyFeedbackSubmitEvent event, Emitter emit) async {
    emit(state.copyWith(showLoadingDialog: true));

    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userInfoRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid);

    final userInfo = await userInfoRef.get();

    String userName = userInfo.data()!['name'];
    String imgUrl = userInfo.data()!['avatar'];
    final feedbackColRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.productFeedback);

    await feedbackColRef.add({
      'bookID': event.bookID,
      'user': userName,
      'userImg': imgUrl,
      'dateSubmit': DateTime.now(),
      'rating': event.rating,
      'review': event.review,
      'isHide': false,
      'isLiked': false,
      'isRead': false,
      'isReply': false,
      'adminReply': '',
      'userId': uid,
    }).then((value) async {
      // String uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection(FirebaseCollections.user)
          .doc(uid)
          .collection(FirebaseCollections.myFeedback)
          .doc(event.feedbackID)
          .delete()
          .then((value) {
        emit(state.copyWith(showLoadingDialog: false));
        Fluttertoast.showToast(msg: 'Cảm ơn bạn đã đánh giá sản phẩm');
      });
    });
  }
}
