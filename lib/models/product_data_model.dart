import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDataModel {
  final String id;
  final String title;
  final String description;
  final String type;
  final String author;
  final String publisher;
  final String publishingYear;
  final double price;
  final double discount;
  final double star;
  final int totalSold;
  final List<String> imageURL;

  ProductDataModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.author,
      required this.publisher,
      required this.publishingYear,
      required this.price,
      required this.discount,
      required this.star,
      required this.totalSold,
      required this.imageURL});

  factory ProductDataModel.fromShapshot(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
    // List<String> url
  ) {
    final data = documentSnapshot.data()!;

    return ProductDataModel(
      id: documentSnapshot.id,
      title: data['title'],
      description: data['description'],
      type: data['type'],
      author: data['author'],
      publisher: data['publisher'],
      publishingYear: data['publishingYear'],
      price: double.parse(data['price'].toString()),
      discount: double.parse(data['discount'].toString()),
      star: double.parse(data['star'].toString()),
      totalSold: int.parse(data['totalSold'].toString()),
      imageURL: List.from(data['listURL']),
    );
  }
}
