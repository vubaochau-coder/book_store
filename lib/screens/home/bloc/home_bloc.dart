import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/models/advertising_model.dart';
import 'package:book_store/models/short_protduct_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeLoadingEvent>(homeLoadingEvent);
  }

  Future<FutureOr<void>> homeLoadingEvent(
      HomeLoadingEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    List<ShortProductDataModel> productDatas = [];
    List<AdvertisingDataModel> advertisingDatas = [];

    final allProductQuery = await FirebaseFirestore.instance
        .collection("Book")
        .orderBy('totalSold', descending: true)
        .limit(10)
        .get();
    for (var ele in allProductQuery.docs) {
      productDatas.add(ShortProductDataModel.fromSnapshot(ele));
    }

    final adQuery =
        await FirebaseFirestore.instance.collection("Advertisement").get();
    for (var ele in adQuery.docs) {
      advertisingDatas.add(AdvertisingDataModel.fromSnapshot(ele));
    }

    emit(HomeLoadingSuccessfulState(
      products: productDatas,
      advertisements: advertisingDatas,
    ));
  }
}
