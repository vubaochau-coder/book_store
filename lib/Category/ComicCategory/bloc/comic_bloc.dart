import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/product_data_model.dart';
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
    List<ProductDataModel> productDatas = [];

    switch (event.options) {
      case 0:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt003')
            .orderBy('totalSold', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ProductDataModel.fromShapshot(ele));
        }
        break;
      case 1:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt003')
            .orderBy('price', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ProductDataModel.fromShapshot(ele));
        }
        break;
      case 2:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt003')
            .orderBy('price', descending: false)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ProductDataModel.fromShapshot(ele));
        }
        break;
    }

    emit(ComicLoadingSuccessfulState(
        listComic: productDatas, sortType: event.options));
  }
}
