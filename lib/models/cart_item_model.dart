import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CartItemModel extends Equatable {
  final String id;
  final String bookID;
  final String title;
  final int count;
  final double price;
  final double priceBeforeDiscount;
  final String imgUrl;
  final bool isSelected;

  @override
  List<Object?> get props => [
        id,
        bookID,
        title,
        count,
        price,
        priceBeforeDiscount,
        imgUrl,
        isSelected
      ];

  const CartItemModel({
    required this.id,
    required this.bookID,
    required this.count,
    required this.price,
    required this.imgUrl,
    required this.title,
    required this.isSelected,
    required this.priceBeforeDiscount,
  });

  factory CartItemModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
      double pPrice,
      double pBPrice,
      String url,
      String pTitle) {
    final data = documentSnapshot.data()!;
    return CartItemModel(
      id: documentSnapshot.id,
      bookID: data['productID'],
      count: int.parse(data['count'].toString()),
      price: pPrice,
      imgUrl: url,
      title: pTitle,
      isSelected: false,
      priceBeforeDiscount: pBPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productID': bookID,
      'count': count,
    };
  }
}
