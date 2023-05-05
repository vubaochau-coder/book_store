import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/models/advertising_model.dart';
import 'package:book_store/models/product_data_model.dart';
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

    List<ProductDataModel> productDatas = [];
    List<AdvertisingDataModel> advertisingDatas = [];

    // final bookCollection = FirebaseFirestore.instance.collection('Book');
    // try {
    //   for (ProductDemoData ele in ProductDemoData.demoBt002Datas) {
    //     await FirebaseFirestore.instance
    //         .collection('Book')
    //         .add(ele.toJson())
    //         .then((value) => print('add success'))
    //         .onError(
    //             (error, stackTrace) => print('error: ' + error.toString()));
    //   }
    // } on Exception catch (e) {
    //   print("add error: " + e.toString());
    // }

    final allProductQuery = await FirebaseFirestore.instance
        .collection("Book")
        .orderBy('totalSold', descending: true)
        .limit(10)
        .get();
    for (var ele in allProductQuery.docs) {
      // List<String> imgUrls = [];
      // String imgPath = ele.get('images');
      // var urlRef = await FirebaseStorage.instance
      //     .ref()
      //     .child("Book")
      //     .child(imgPath)
      //     .listAll();
      // for (var imgItem in urlRef.items) {
      //   String downloadURL = await imgItem.getDownloadURL();
      //   imgUrls.add(downloadURL);
      // }

      // await FirebaseFirestore.instance
      //     .collection('Book')
      //     .doc(ele.id)
      //     .update({'listURL': imgUrls});

      productDatas.add(ProductDataModel.fromShapshot(
        ele, /*imgUrls*/
      ));
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
