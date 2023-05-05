import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/models/product_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'sgk_event.dart';
part 'sgk_state.dart';

class SgkBloc extends Bloc<SgkEvent, SgkState> {
  SgkBloc() : super(SgkLoadingState()) {
    on<SgkLoadEvent>(sgkLoadingEvent);
  }

  FutureOr<void> sgkLoadingEvent(
      SgkLoadEvent event, Emitter<SgkState> emit) async {
    emit(SgkLoadingState());
    List<ProductDataModel> productDatas = [];
    switch (event.options) {
      case 0:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt001')
            .orderBy('totalSold', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ProductDataModel.fromShapshot(ele));
        }
        break;
      case 1:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt001')
            .orderBy('price', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ProductDataModel.fromShapshot(ele));
        }
        break;
      case 2:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt001')
            .orderBy('price', descending: false)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ProductDataModel.fromShapshot(ele));
        }
        break;
    }

    emit(SgkLoadingSuccessfulState(
        listSGK: productDatas, sortType: event.options));
  }
}
