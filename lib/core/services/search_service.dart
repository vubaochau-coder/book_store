import 'package:book_store/core/constant/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/search_list_singleton.dart';
import '../models/search_suggestion_model.dart';
import '../models/short_protduct_data_model.dart';

class SearchService {
  Future<List<SearchSuggestionModel>> getRecentSearch() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    List<SearchSuggestionModel> recentSearch = [];
    SearchListSingleton();

    final searchQuery = await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.search)
        .orderBy('date', descending: true)
        .limit(8)
        .get();

    for (var ele in searchQuery.docs) {
      SearchSuggestionModel temp = SearchSuggestionModel.fromSnapshot(ele);
      recentSearch.add(temp);
    }
    return recentSearch;
  }

  Future<void> addNewQuery(String newQuery) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final searchRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.search);

    await searchRef.add(SearchSuggestionModel(
      id: '',
      query: newQuery,
      date: DateTime.now(),
    ).toJson());
  }

  Future<void> updateQueryIndex(String query) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = await FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.search)
        .where('query', isEqualTo: query)
        .get();

    await Future.wait([
      ...docRef.docs.map(
        (e) => FirebaseFirestore.instance
            .collection(FirebaseCollections.user)
            .doc(uid)
            .collection(FirebaseCollections.search)
            .doc(e.id)
            .update(
          {'date': DateTime.now()},
        ),
      )
    ]);
  }

  Future<void> removeSearch(String searchId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final docRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.user)
        .doc(uid)
        .collection(FirebaseCollections.search)
        .doc(searchId);

    await docRef.delete();
  }

  Future<List<ShortProductDataModel>> getProductData(
      List<String> productIds) async {
    List<ShortProductDataModel> searchResult = [];

    final query = await Future.wait([
      ...productIds.map(
        (e) => FirebaseFirestore.instance.collection('Book').doc(e).get(),
      )
    ]);

    for (var ele in query) {
      searchResult.add(ShortProductDataModel.fromSnapshot(ele));
    }
    return searchResult;
  }
}
