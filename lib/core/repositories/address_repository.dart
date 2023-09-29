import 'package:book_store/core/services/address_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/address_model.dart';

class AddressRepository {
  late AddressService _service;

  AddressRepository() {
    _service = AddressService();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userAddressStream() {
    return _service.userAddressStream();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userMainAddressStream() {
    return _service.userMainAddressStream();
  }

  Future<void> updateDefaultAddress(String newAddressId) async {
    return _service.updateDefaultAddress(newAddressId);
  }

  Future<void> removeAddress(String addressId) async {
    return _service.removeAddress(addressId);
  }

  Future<void> createAddress(AddressModel address) async {
    return _service.createAddress(address);
  }
}
