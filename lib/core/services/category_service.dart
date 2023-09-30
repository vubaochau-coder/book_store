import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/short_protduct_data_model.dart';

class CategoryService {
  Future<List<ShortProductDataModel>> getBookingByType(String type) async {
    List<ShortProductDataModel> books = [];

    final booksQuery = await FirebaseFirestore.instance
        .collection(FirebaseCollections.book)
        .where('type', isEqualTo: type)
        .get();

    for (var ele in booksQuery.docs) {
      books.add(ShortProductDataModel.fromSnapshot(ele));
    }
    return books;
  }
}
