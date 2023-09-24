import 'package:bloc/bloc.dart';
import 'package:book_store/models/advertising_model.dart';
import 'package:book_store/models/short_protduct_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeLoadingEvent>(_onLoading);
  }

  _onLoading(HomeLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    List<ShortProductDataModel> productDatas = [];
    List<AdvertisingDataModel> advertisingDatas = [];

    final futureGroup = await Future.wait([
      FirebaseFirestore.instance
          .collection("Book")
          .orderBy('totalSold', descending: true)
          .limit(10)
          .get(),
      FirebaseFirestore.instance.collection("Advertisement").get(),
    ]);

    final allProductQuery = futureGroup[0];
    for (var ele in allProductQuery.docs) {
      productDatas.add(ShortProductDataModel.fromSnapshot(ele));
    }

    final adQuery = futureGroup[1];
    for (var ele in adQuery.docs) {
      advertisingDatas.add(AdvertisingDataModel.fromSnapshot(ele));
    }

    emit(state.copyWith(
      isLoading: false,
      products: productDatas,
      advertisements: advertisingDatas,
    ));
  }
}
