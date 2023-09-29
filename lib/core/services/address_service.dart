import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:book_store/core/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressService {
  Stream<QuerySnapshot<Map<String, dynamic>>> userAddressStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.userAddress)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userMainAddressStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.userAddress)
        .where('isDefault', isEqualTo: true)
        .snapshots();
  }

  Future<void> updateDefaultAddress(String newAddressId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userAddColRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.userAddress);
    final defaultAddress =
        await userAddColRef.where('isDefault', isEqualTo: true).get();

    await Future.wait([
      ...defaultAddress.docs.map(
        (e) => e.reference.set(
          {'isDefault': false},
          SetOptions(merge: true),
        ),
      ),
      ...[
        userAddColRef
            .doc(newAddressId)
            .set({'isDefault': true}, SetOptions(merge: true)),
      ]
    ]);
  }

  Future<void> removeAddress(String addressId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userAddColRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.userAddress);

    await userAddColRef.doc(addressId).delete();
  }

  Future<void> createAddress(AddressModel address) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.userAddress)
        .add(address.toJson());
  }
}
