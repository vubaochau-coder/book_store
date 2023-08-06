import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/short_protduct_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'literature_event.dart';
part 'literature_state.dart';

class LiteratureBloc extends Bloc<LiteratureEvent, LiteratureState> {
  LiteratureBloc() : super(LiteratureLoadingState()) {
    on<LiteratureLoadEvent>(literatureLoadEvent);
  }

  FutureOr<void> literatureLoadEvent(
      LiteratureLoadEvent event, Emitter<LiteratureState> emit) async {
    emit(LiteratureLoadingState());
    List<ShortProductDataModel> productDatas = [];

    switch (event.options) {
      case 0:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt002')
            .orderBy('totalSold', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 1:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt002')
            .orderBy('price', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 2:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt002')
            .orderBy('price', descending: false)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
    }

    emit(LiteratureLoadingSuccessfulState(
        listLiterature: productDatas, sortType: event.options));
  }
}
