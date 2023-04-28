import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/models/advertising_model.dart';
import 'package:book_store/models/product_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeLoadingEvent>(homeLoadingEvent);
  }

  Future<FutureOr<void>> homeLoadingEvent(
      HomeLoadingEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    List<ProductDataModel> productDatas = [];
    List<AdvertisingDataModel> advertisingDatas = [];

    final allProductQuery = await FirebaseFirestore.instance
        .collection("Book")
        .orderBy('totalSold', descending: true)
        // .limit(10)
        .get();
    for (var ele in allProductQuery.docs) {
      List<String> imgUrls = [];
      String imgPath = ele.get('images');
      var urlRef = await FirebaseStorage.instance
          .ref()
          .child("Book")
          .child(imgPath)
          .listAll();
      for (var imgItem in urlRef.items) {
        String downloadURL = await imgItem.getDownloadURL();
        imgUrls.add(downloadURL);
      }
      productDatas.add(ProductDataModel.fromShapshot(ele, imgUrls));
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
