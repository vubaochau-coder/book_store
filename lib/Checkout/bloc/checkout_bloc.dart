import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/address_model.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:book_store/models/transport_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutLoadingState()) {
    on<CheckoutLoadingEvent>(checkoutLoadingEvent);
    on<CheckoutUpdateEmptyAddressEvent>(checkoutUpdateEmptyEvent);
    on<CheckoutUpdateEvent>(checkoutUpdateEvent);
    on<CheckoutOrderEvent>(checkoutOrderEvent);
  }

  FutureOr<void> checkoutLoadingEvent(
      CheckoutLoadingEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .snapshots()
        .listen((event) async {
      if (event.exists) {
        AddressModel userAddress;
        List<TransportModel> transports = [];

        final addressCodeQuery =
            await FirebaseFirestore.instance.collection('User').doc(uid).get();

        String addressCode =
            await addressCodeQuery.data()!['defaultAddress'] ?? '';

        if (addressCode == '') {
          userAddress = const AddressModel(
              id: '', name: '', phone: '', address: '', isDefault: false);
        } else {
          final addressQuery = await FirebaseFirestore.instance
              .collection('User')
              .doc(uid)
              .collection('Address')
              .doc(addressCode)
              .get();
          userAddress = AddressModel.fromSnapshot(addressQuery, true);
        }

        final transportQuery =
            await FirebaseFirestore.instance.collection('Transport').get();
        for (int i = 0; i < transportQuery.size; i++) {
          if (i == 0) {
            transports
                .add(TransportModel.fromSnapshot(transportQuery.docs[i], true));
          } else {
            transports.add(
                TransportModel.fromSnapshot(transportQuery.docs[i], false));
          }
        }
        add(CheckoutUpdateEvent(
            newAddress: userAddress, transports: transports));
      } else {
        List<TransportModel> transports = [];
        final transportQuery =
            await FirebaseFirestore.instance.collection('Transport').get();
        for (int i = 0; i < transportQuery.size; i++) {
          if (i == 0) {
            transports
                .add(TransportModel.fromSnapshot(transportQuery.docs[i], true));
          } else {
            transports.add(
                TransportModel.fromSnapshot(transportQuery.docs[i], false));
          }
        }
        add(CheckoutUpdateEmptyAddressEvent(transports: transports));
      }
    });
  }

  FutureOr<void> checkoutUpdateEvent(
      CheckoutUpdateEvent event, Emitter<CheckoutState> emit) async {
    if (state is CheckoutLoadingState) {
      emit(CheckoutLoadingSuccessfulState(
        userAddress: event.newAddress,
        transports: event.transports,
        showLoadingDialog: false,
      ));
    } else if (state is CheckoutLoadingSuccessfulState) {
      List<TransportModel> temp2 = [];

      temp2.addAll(event.transports);

      emit(CheckoutLoadingSuccessfulState(
        userAddress: event.newAddress,
        transports: temp2,
        showLoadingDialog: false,
      ));
    } else if (state is CheckoutEmptyAddressState) {
      List<TransportModel> temp2 = [];

      temp2.addAll(event.transports);

      emit(CheckoutLoadingSuccessfulState(
        userAddress: event.newAddress,
        transports: temp2,
        showLoadingDialog: false,
      ));
    }
  }

  FutureOr<void> checkoutUpdateEmptyEvent(CheckoutUpdateEmptyAddressEvent event,
      Emitter<CheckoutState> emit) async {
    emit(CheckoutEmptyAddressState(transports: event.transports));
  }

  FutureOr<void> checkoutOrderEvent(
      CheckoutOrderEvent event, Emitter<CheckoutState> emit) async {
    if (state is CheckoutLoadingSuccessfulState) {
      final currentState = state as CheckoutLoadingSuccessfulState;
      emit(
        CheckoutLoadingSuccessfulState(
            userAddress: currentState.userAddress,
            transports: currentState.transports,
            showLoadingDialog: true),
      );

      String uid = FirebaseAuth.instance.currentUser!.uid;

      try {
        final transactionCollection = FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Transaction');

        await transactionCollection
            .add(event.transaction.toJson())
            .then((value) async {
          for (var ele in event.transaction.products) {
            await FirebaseFirestore.instance
                .collection('User')
                .doc(uid)
                .collection('Transaction')
                .doc(value.id)
                .collection('Products')
                .add(ele.toJson());
          }

          if (event.fromCart) {
            final cartCollection = FirebaseFirestore.instance
                .collection('User')
                .doc(uid)
                .collection('Cart');
            for (var ele in event.transaction.products) {
              await cartCollection.doc(ele.id).delete();
            }
          }

          emit(CheckoutOrderSuccessfulState(idTransaction: value.id));
        });
      } on FirebaseException catch (e) {
        emit(
          CheckoutLoadingSuccessfulState(
            userAddress: currentState.userAddress,
            transports: currentState.transports,
            showLoadingDialog: false,
          ),
        );
        Fluttertoast.showToast(msg: "Error: ${e.message}");
      }
    }
  }
}
