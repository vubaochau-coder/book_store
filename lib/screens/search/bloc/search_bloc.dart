import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/search_list_singleton.dart';
import 'package:book_store/models/search_suggestion_model.dart';
import 'package:book_store/models/short_protduct_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchLoadingState()) {
    on<SearchLoadingEvent>(searchLoadingEvent);
    on<SearchingEvent>(searchingEvent);
    on<SearchRemoveEvent>(searchRemoveEvent);
  }

  FutureOr<void> searchLoadingEvent(
      SearchLoadingEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;
    SearchListSingleton();

    final searchQuery = await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Search')
        .orderBy('date', descending: true)
        .limit(8)
        .get();
    List<SearchSuggestionModel> recentSearch = [];
    for (var ele in searchQuery.docs) {
      SearchSuggestionModel temp = SearchSuggestionModel.fromSnapshot(ele);
      recentSearch.add(temp);
    }

    emit(SearchLoadingSuccessfulState(searchedList: recentSearch));
  }

  FutureOr<void> searchingEvent(
      SearchingEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;
    if (event.isNewQuery) {
      final searchRef = FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('Search');

      await searchRef.add(SearchSuggestionModel(
              id: '', query: event.query, date: DateTime.now())
          .toJson());
    } else {
      final docRef = await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .collection('Search')
          .where('query', isEqualTo: event.query)
          .get();

      for (var ele in docRef.docs) {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .collection('Search')
            .doc(ele.id)
            .update({'date': DateTime.now()});
      }
    }

    String query = removeDiacritics(event.query.toLowerCase());

    SearchListSingleton dataList = SearchListSingleton();
    List<String> idResult = [];
    List<ShortProductDataModel> searchResult = [];

    for (var data in dataList.dataList) {
      if (data.searchKey.contains(query)) {
        idResult.add(data.bookID);
      }
    }

    if (idResult.isNotEmpty) {
      for (var id in idResult) {
        final book =
            await FirebaseFirestore.instance.collection('Book').doc(id).get();
        searchResult.add(ShortProductDataModel.fromSnapshot(book));
      }
    }

    emit(SearchCompletedState(query: event.query, searchResult: searchResult));
  }

  FutureOr<void> searchRemoveEvent(
      SearchRemoveEvent event, Emitter<SearchState> emit) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final docRef = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Search')
        .doc(event.idRemove);

    await docRef.delete();

    final searchQuery = await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Search')
        .orderBy('date', descending: true)
        .limit(8)
        .get();
    List<SearchSuggestionModel> recentSearch = [];
    for (var ele in searchQuery.docs) {
      SearchSuggestionModel temp = SearchSuggestionModel.fromSnapshot(ele);
      recentSearch.add(temp);
    }

    emit(SearchLoadingSuccessfulState(searchedList: recentSearch));
  }
}
