import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/short_protduct_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'other_event.dart';
part 'other_state.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  OtherBloc() : super(OtherLoadingState()) {
    on<OtherLoadEvent>(otherLoadEvent);
  }

  FutureOr<void> otherLoadEvent(
      OtherLoadEvent event, Emitter<OtherState> emit) async {
    emit(OtherLoadingState());
    List<ShortProductDataModel> productDatas = [];

    switch (event.options) {
      case 0:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt006')
            .orderBy('totalSold', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 1:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt006')
            .orderBy('price', descending: true)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
      case 2:
        final allProductQuery = await FirebaseFirestore.instance
            .collection("Book")
            .where('type', isEqualTo: 'bt006')
            .orderBy('price', descending: false)
            .get();
        for (var ele in allProductQuery.docs) {
          productDatas.add(ShortProductDataModel.fromSnapshot(ele));
        }
        break;
    }

    emit(OtherLoadingSuccessfulState(
        listOther: productDatas, sortType: event.options));
  }
}
