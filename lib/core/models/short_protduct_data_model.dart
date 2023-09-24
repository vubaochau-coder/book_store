import 'package:cloud_firestore/cloud_firestore.dart';

class ShortProductDataModel {
  final String id;
  final String title;
  final String type;
  final String imgURL;
  final double price;
  final double discount;
  final int totalSold;

  ShortProductDataModel({
    required this.id,
    required this.title,
    required this.type,
    required this.imgURL,
    required this.price,
    required this.discount,
    required this.totalSold,
  });

  factory ShortProductDataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return ShortProductDataModel(
      id: snapshot.id,
      title: snapshot.get('title'),
      type: snapshot.get('type'),
      imgURL: List.from(data['listURL'])[0],
      price: double.parse(data['price'].toString()),
      discount: double.parse(data['discount'].toString()),
      totalSold: int.parse(data['totalSold'].toString()),
    );
  }
}
