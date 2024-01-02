import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/short_protduct_data_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/repositories/category_repository.dart';
import '../../category_enum.dart';

part 'comic_event.dart';
part 'comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final CategoryRepository _categoryRepository;

  ComicBloc(this._categoryRepository) : super(const ComicState()) {
    on<ComicLoadEvent>(_onLoading);
    on<UpdateSortTypeEvent>(_updateSortType);
  }

  _onLoading(ComicLoadEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    List<ShortProductDataModel> productDatas =
        await _categoryRepository.getBookingByType('bt003');

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
        listComic: productDatas,
      ),
    );
  }

  _updateSortType(UpdateSortTypeEvent event, Emitter emit) {
    if (event.newType != state.sortType) {
      List<ShortProductDataModel> newList = List.from(state.listComic);

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
      emit(state.copyWith(sortType: event.newType, listComic: newList));
    }
  }
}
