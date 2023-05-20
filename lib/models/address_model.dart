import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String address;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.isDefault,
  });

  factory AddressModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot, bool check) {
    return AddressModel(
      id: snapshot.id,
      name: snapshot.data()!['name'],
      phone: snapshot.data()!['phone'],
      address: snapshot.data()!['address'],
      isDefault: check,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'isDefault': isDefault,
    };
  }

  @override
  List<Object?> get props => [id, name, phone, address, isDefault];
}
