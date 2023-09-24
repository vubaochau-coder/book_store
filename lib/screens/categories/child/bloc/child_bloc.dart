import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/short_protduct_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'child_event.dart';
part 'child_state.dart';

class ChildBloc extends Bloc<ChildEvent, ChildState> {
  ChildBloc() : super(ChildLoadingState()) {
    on<ChildLoadEvent>(childLoadEvent);
  }

  FutureOr<void> childLoadEvent(
      ChildLoadEvent event, Emitter<ChildState> emit) async {
    emit(ChildLoadingState());
    List<ShortProductDataModel> productDatas = [];

    switch (event.options) {
      case 0:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt004')
            .orderBy('totalSold', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 1:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt004')
            .orderBy('price', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 2:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt004')
            .orderBy('price', descending: false)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
    }

    emit(ChildLoadingSuccessfulState(
        listChild: productDatas, sortType: event.options));
  }
}
