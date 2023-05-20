import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressLoadingState()) {
    on<AddressLoadingEvent>(addressLoadingEvent);
    on<AddNewAddressEvent>(addNewAddressEvent);
    on<RemoveAddressEvent>(removeAddressEvent);
    on<AddressUpdateEvent>(addressUpdateEvent);
    on<AddressUpdateEmptyEvent>(addressUpdateEmptyEvent);
    on<AddressSelectedEvent>(addressSelectedEvent);
  }

  FutureOr<void> addressLoadingEvent(
      AddressLoadingEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;
    String addressCode = '';

    final addressCodeQuery =
        await FirebaseFirestore.instance.collection('User').doc(uid).get();

    if (addressCodeQuery.data() != null) {
      addressCode = await addressCodeQuery.data()!['defaultAddress'] ?? '';
    }

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Address')
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        List<AddressModel> listResult = [];

        for (var ele in event.docs) {
          if (ele.id == addressCode) {
            listResult.add(AddressModel.fromSnapshot(ele, true));
          } else {
            listResult.add(AddressModel.fromSnapshot(ele, false));
          }
        }

        add(AddressUpdateEvent(listAddress: listResult));
      } else {
        add(AddressUpdateEmptyEvent());
      }
    });
  }

  FutureOr<void> addNewAddressEvent(
      AddNewAddressEvent event, Emitter<AddressState> emit) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Address')
        .add(event.newAddress.toJson())
        .then((value) {
      Fluttertoast.showToast(msg: 'Thêm địa chỉ mới thành công');
      add(AddressLoadingEvent());
    }).catchError((err) {
      Fluttertoast.showToast(
        msg: err.toString(),
      );
    });
  }

  FutureOr<void> removeAddressEvent(
      RemoveAddressEvent event, Emitter<AddressState> emit) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Address')
        .doc(event.idAddress);

    await docRef.delete().then((value) {
      Fluttertoast.showToast(msg: 'Xóa thành công');
      add(AddressLoadingEvent());
    }).catchError((err) {
      Fluttertoast.showToast(
        msg: err.toString(),
      );
    });
  }

  FutureOr<void> addressUpdateEvent(
      AddressUpdateEvent event, Emitter<AddressState> emit) {
    if (state is AddressLoadingState) {
      emit(AddressLoadingSuccessfulState(listAddress: event.listAddress));
    } else if (state is AddressLoadingSuccessfulState) {
      final currentState = state as AddressLoadingSuccessfulState;

      if (currentState.listAddress.isNotEmpty) {
        currentState.listAddress.clear();
      }

      List<AddressModel> temp = [];
      temp.addAll(event.listAddress);

      emit(AddressLoadingSuccessfulState(listAddress: temp));
    } else if (state is AddressEmptyState) {
      emit(AddressLoadingSuccessfulState(listAddress: event.listAddress));
    }
  }

  FutureOr<void> addressUpdateEmptyEvent(
      AddressUpdateEmptyEvent event, Emitter<AddressState> emit) {
    emit(AddressEmptyState());
  }

  FutureOr<void> addressSelectedEvent(
      AddressSelectedEvent event, Emitter<AddressState> emit) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;

    final updateRef = FirebaseFirestore.instance.collection('User').doc(userID);

    updateRef.set(
        {'defaultAddress': event.id},
        SetOptions(
          merge: true,
        )).then((value) {
      Fluttertoast.showToast(msg: 'Thay đổi địa chỉ thành công');
      add(AddressLoadingEvent());
    }).catchError((err) {
      Fluttertoast.showToast(
        msg: err.toString(),
      );
    });

    // await updateRef.update({'defaultAddress': event.id}).then((value) {
    //   Fluttertoast.showToast(msg: 'Thay đổi địa chỉ thành công');
    //   add(AddressLoadingEvent());
    // }).catchError((err) {
    //   Fluttertoast.showToast(
    //     msg: err.toString(),
    //   );
    // });
  }
}
