import 'package:book_store/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String dateCreated;
  final String dateCompleted;
  final String address;
  final String transport;
  final String note;
  final double totalPrice;
  final double productPrice;
  final double transportPrice;
  final List<CartItemModel> products;
  final int status;

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
  });

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      List<CartItemModel> products) {
    return TransactionModel(
      id: snapshot.id,
      address: snapshot.get('address'),
      dateCompleted: snapshot.get('dateCompleted'),
      dateCreated: snapshot.get('dateCreated'),
      note: snapshot.get('note'),
      productPrice: snapshot.get('productPrice'),
      status: int.parse(snapshot.get('status').toString()),
      totalPrice: double.parse(snapshot.get('totalPrice').toString()),
      transportPrice: double.parse(snapshot.get('transportPrice').toString()),
      transport: snapshot.get('transport'),
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
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
    };
  }
}
