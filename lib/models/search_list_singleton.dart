import 'package:book_store/models/search_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchListSingleton {
  static SearchListSingleton? _instance;

  List<SearchDataModel> dataList = [];

  factory SearchListSingleton() =>
      _instance ??= SearchListSingleton._internal();

  SearchListSingleton._internal() {
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    final query = await FirebaseFirestore.instance.collection('Book').get();
    for (var ele in query.docs) {
      String id = ele.id;
      String key = ele.get('searchKey');

      SearchDataModel temp = SearchDataModel(bookID: id, searchKey: key);

      dataList.add(temp);
    }
  }
}
