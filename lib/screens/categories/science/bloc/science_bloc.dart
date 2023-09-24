import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/short_protduct_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'science_event.dart';
part 'science_state.dart';

class ScienceBloc extends Bloc<ScienceEvent, ScienceState> {
  ScienceBloc() : super(ScienceLoadingState()) {
    on<ScicenceLoadEvent>(ccicenceLoadEvent);
  }

  FutureOr<void> ccicenceLoadEvent(
      ScicenceLoadEvent event, Emitter<ScienceState> emit) async {
    emit(ScienceLoadingState());
    List<ShortProductDataModel> productDatas = [];

    switch (event.options) {
      case 0:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt005')
            .orderBy('totalSold', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 1:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt005')
            .orderBy('price', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 2:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt005')
            .orderBy('price', descending: false)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
    }

    emit(ScienceLoadingSuccessfulState(
        listScience: productDatas, sortType: event.options));
  }
}
