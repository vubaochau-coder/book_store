import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  Future<void> increateTotalSold(String bookId, int count) async {
    final bookRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.book)
        .doc(bookId);

    final book = await bookRef.get();
    int temp = int.parse(book.get('totalSold').toString());
    temp += count;
    await bookRef.update({'totalSold': temp});
  }
}
