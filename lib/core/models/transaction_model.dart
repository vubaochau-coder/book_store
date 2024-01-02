import 'package:book_store/core/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final DateTime dateCreated;
  final DateTime dateCompleted;
  final String address;
  final String userName;
  final String phone;
  final String transport;
  final String note;
  final double totalPrice;
  final double productPrice;
  final double transportPrice;
  final List<CartItemModel> products;
  final int status;
  final bool paid;
  final String paymentMethod;

  TransactionModel({
    required this.id,
    required this.dateCreated,
    required this.dateCompleted,
    required this.address,
    required this.transport,
    required this.note,
    required this.totalPrice,
    required this.productPrice,
    required this.transportPrice,
    required this.products,
    required this.status,
    required this.paid,
    required this.paymentMethod,
    required this.userName,
    required this.phone,
  });

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      List<CartItemModel> products) {
    Timestamp create = snapshot.get('dateCreated');
    Timestamp completed = snapshot.get('dateCompleted');
    return TransactionModel(
      id: snapshot.id,
      address: snapshot.get('address'),
      dateCompleted: completed.toDate(),
      dateCreated: create.toDate(),
      note: snapshot.get('note'),
      productPrice: snapshot.get('productPrice'),
      status: int.parse(snapshot.get('status').toString()),
      totalPrice: double.parse(snapshot.get('totalPrice').toString()),
      transportPrice: double.parse(snapshot.get('transportPrice').toString()),
      transport: snapshot.get('transport'),
      paid: snapshot.get('paid'),
      paymentMethod: snapshot.get('paymentMethod'),
      products: products,
      userName: snapshot.data()!['userName'] ?? "",
      phone: snapshot.data()!['phone'] ?? "",
    );
  }

  Map<String, dynamic> toJson(String uid) {
    List<Map<String, dynamic>> p = [];
    for (var ele in products) {
      p.add(ele.toJson());
    }
    int transportCode = transport == "Cơ bản"
        ? 1
        : transport == "Nhanh"
            ? 2
            : 3;

    return {
      'dateCreated': dateCreated,
      'dateCompleted': dateCompleted,
      'address': address,
      'transport': transport,
      'note': note,
      'totalPrice': totalPrice,
      'productPrice': productPrice,
      'transportPrice': transportPrice,
      'status': status,
      'paid': paid,
      'paymentMethod': paymentMethod,
      'userName': userName,
      'phone': phone,
      'userId': uid,
      'products': p,
      'transportCode': transportCode,
    };
  }
}
