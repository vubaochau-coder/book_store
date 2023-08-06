import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'bill_event.dart';
part 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(BillLoadingState()) {
    on<BillLoadingEvent>(billLoadingEvent);
  }

  FutureOr<void> billLoadingEvent(
      BillLoadingEvent event, Emitter<BillState> emit) async {
    emit(BillLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    final transactionQuery = await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Transaction')
        .doc(event.billID)
        .get();

    TransactionModel data = TransactionModel.fromSnapshot(transactionQuery, []);

    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        emit(BillLoadingSuccessfulState(info: data));
      },
    );
  }
}
