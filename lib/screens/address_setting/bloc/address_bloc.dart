import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/address_model.dart';
import 'package:book_store/core/repositories/address_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  StreamSubscription? _addressStream;
  final AddressRepository _addressRepository;

  AddressBloc(this._addressRepository) : super(const AddressState()) {
    on<AddressLoadingEvent>(_onLoading);
    on<AddNewAddressEvent>(_onAddNewAddress);
    on<RemoveAddressEvent>(_onRemoveAddress);
    on<AddressUpdateEvent>(_onUpdate);
    on<AddressUpdateEmptyEvent>(_onUpdateEmpty);
    on<AddressSelectedEvent>(_onAddressSelected);
  }

  @override
  Future<void> close() async {
    _addressStream?.cancel();
    _addressStream = null;
    super.close();
  }

  _onLoading(AddressLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    _addressStream =
        _addressRepository.userAddressStream().listen((event) async {
      if (event.docs.isNotEmpty) {
        List<AddressModel> listResult = [];

        for (var ele in event.docs) {
          listResult.add(AddressModel.fromSnapshot(ele));
        }

        if (!isClosed) {
          add(AddressUpdateEvent(listAddress: listResult));
        }
      } else {
        add(AddressUpdateEmptyEvent());
      }
    });
  }

  _onAddNewAddress(AddNewAddressEvent event, Emitter emit) async {
    await _addressRepository.createAddress(event.newAddress).then((value) {
      Fluttertoast.showToast(msg: 'Thêm địa chỉ mới thành công');
    });
  }

  _onRemoveAddress(RemoveAddressEvent event, Emitter emit) async {
    await _addressRepository.removeAddress(event.idAddress).then((value) {
      Fluttertoast.showToast(msg: 'Xóa thành công');
    });
  }

  _onUpdate(AddressUpdateEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: false, listAddress: event.listAddress));
  }

  _onUpdateEmpty(AddressUpdateEmptyEvent event, Emitter emit) {
    emit(state.copyWith(isLoading: false, listAddress: []));
  }

  _onAddressSelected(AddressSelectedEvent event, Emitter emit) async {
    await _addressRepository.updateDefaultAddress(event.id).then((value) {
      Fluttertoast.showToast(msg: 'Thay đổi địa chỉ thành công');
    });
  }
}
