import 'package:bloc/bloc.dart';
import 'package:book_store/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(const AddressState()) {
    on<AddressLoadingEvent>(_onLoading);
    on<AddNewAddressEvent>(_onAddNewAddress);
    on<RemoveAddressEvent>(_onRemoveAddress);
    on<AddressUpdateEvent>(_onUpdate);
    on<AddressUpdateEmptyEvent>(_onUpdateEmpty);
    on<AddressSelectedEvent>(_onAddressSelected);
  }

  _onLoading(AddressLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

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

  _onAddNewAddress(AddNewAddressEvent event, Emitter emit) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Address')
        .add(event.newAddress.toJson())
        .then((value) {
      Fluttertoast.showToast(msg: 'Thêm địa chỉ mới thành công');
    }).catchError((err) {
      Fluttertoast.showToast(
        msg: err.toString(),
      );
    });
  }

  _onRemoveAddress(RemoveAddressEvent event, Emitter emit) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('User')
        .doc(userID)
        .collection('Address')
        .doc(event.idAddress);

    await docRef.delete().then((value) {
      Fluttertoast.showToast(msg: 'Xóa thành công');
    }).catchError((err) {
      Fluttertoast.showToast(
        msg: err.toString(),
      );
    });
  }

  _onUpdate(AddressUpdateEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: false, listAddress: event.listAddress));
  }

  _onUpdateEmpty(AddressUpdateEmptyEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: false, listAddress: []));
  }

  _onAddressSelected(AddressSelectedEvent event, Emitter emit) async {
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
  }
}
