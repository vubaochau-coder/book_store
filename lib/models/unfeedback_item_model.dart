import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackItemModel {
  final String id;
  final String bookID;
  final String bookTitle;
  final String imgURL;
  final double price;

  FeedbackItemModel({
    required this.id,
    required this.bookID,
    required this.bookTitle,
    required this.imgURL,
    required this.price,
  });

  factory FeedbackItemModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return FeedbackItemModel(
      id: snapshot.id,
      bookID: data['productID'],
      bookTitle: data['bookTitle'],
      imgURL: data['imgURL'],
      price: double.parse(data['price'].toString()),
    );
  }
}
