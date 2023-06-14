import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/short_protduct_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'comic_event.dart';
part 'comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  ComicBloc() : super(ComicLoadingState()) {
    on<ComicLoadEvent>(comicLoadEvent);
  }

  FutureOr<void> comicLoadEvent(
      ComicLoadEvent event, Emitter<ComicState> emit) async {
    emit(ComicLoadingState());
    List<ShortProductDataModel> productDatas = [];

    switch (event.options) {
      case 0:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt003')
            .orderBy('totalSold', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 1:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt003')
            .orderBy('price', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 2:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt003')
            .orderBy('price', descending: false)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
    }

    emit(ComicLoadingSuccessfulState(
        listComic: productDatas, sortType: event.options));
  }
}
