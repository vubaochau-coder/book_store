import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/short_protduct_data_model.dart';
import 'package:book_store/core/repositories/category_repository.dart';
import 'package:equatable/equatable.dart';

import '../../category_enum.dart';

part 'literature_event.dart';
part 'literature_state.dart';

class LiteratureBloc extends Bloc<LiteratureEvent, LiteratureState> {
  final CategoryRepository _categoryRepository;

  LiteratureBloc(this._categoryRepository) : super(const LiteratureState()) {
    on<LiteratureLoadEvent>(_onLoading);
    on<UpdateSortTypeEvent>(_updateSortType);
  }

  _onLoading(LiteratureLoadEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    List<ShortProductDataModel> productDatas =
        await _categoryRepository.getBookingByType('bt002');

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
        listLiterature: productDatas,
      ),
    );
  }

  _updateSortType(UpdateSortTypeEvent event, Emitter emit) {
    if (event.newType != state.sortType) {
      List<ShortProductDataModel> newList = List.from(state.listLiterature);

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
      emit(state.copyWith(sortType: event.newType, listLiterature: newList));
    }
  }
}
