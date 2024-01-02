import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/short_protduct_data_model.dart';
import 'package:book_store/core/repositories/category_repository.dart';
import 'package:book_store/screens/categories/category_enum.dart';
import 'package:equatable/equatable.dart';

part 'other_event.dart';
part 'other_state.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  final CategoryRepository _categoryRepository;

  OtherBloc(this._categoryRepository) : super(const OtherState()) {
    on<OtherLoadEvent>(_onLoading);
    on<UpdateSortTypeEvent>(_updateSortType);
  }

  FutureOr<void> _onLoading(
      OtherLoadEvent event, Emitter<OtherState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<ShortProductDataModel> productDatas =
        await _categoryRepository.getBookingByType('bt006');

    switch (state.sortType) {
      case BookSortType.bestSale:
        productDatas.sort(
          (a, b) => b.totalSold.compareTo(a.totalSold),
        );
        break;
      case BookSortType.descendingCost:
        productDatas.sort(
          (a, b) => b.price.compareTo(a.price),
        );
        break;

      case BookSortType.ascendingCost:
        productDatas.sort(
          (a, b) => a.price.compareTo(b.price),
        );
        break;
    }

    emit(
      state.copyWith(
        isLoading: false,
        listOther: productDatas,
      ),
    );
  }

  _updateSortType(UpdateSortTypeEvent event, Emitter emit) {
    if (event.newType != state.sortType) {
      List<ShortProductDataModel> newList = List.from(state.listOther);

      switch (event.newType) {
        case BookSortType.bestSale:
          newList.sort(
            (a, b) => b.totalSold.compareTo(a.totalSold),
          );
          break;
        case BookSortType.descendingCost:
          newList.sort(
            (a, b) => b.price.compareTo(a.price),
          );
          break;

        case BookSortType.ascendingCost:
          newList.sort(
            (a, b) => a.price.compareTo(b.price),
          );
          break;
      }
      emit(state.copyWith(sortType: event.newType, listOther: newList));
    }
  }
}
