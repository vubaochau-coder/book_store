import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/short_protduct_data_model.dart';
import 'package:book_store/core/repositories/category_repository.dart';
import 'package:book_store/screens/categories/category_enum.dart';
import 'package:equatable/equatable.dart';

part 'child_event.dart';
part 'child_state.dart';

class ChildBloc extends Bloc<ChildEvent, ChildState> {
  final CategoryRepository _categoryRepository;

  ChildBloc(this._categoryRepository) : super(const ChildState()) {
    on<ChildLoadEvent>(_onLoading);
    on<UpdateSortTypeEvent>(_updateSortType);
  }

  _onLoading(ChildLoadEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    List<ShortProductDataModel> productDatas =
        await _categoryRepository.getBookingByType('bt004');

    switch (state.sortType) {
      case BookSortType.bestSale:
        productDatas.sort(
          (a, b) => a.totalSold.compareTo(b.totalSold),
        );
        break;
      case BookSortType.descendingCost:
        productDatas.sort(
          (a, b) => a.price.compareTo(b.price),
        );
        break;

      case BookSortType.ascendingCost:
        productDatas.sort(
          (a, b) => b.price.compareTo(a.price),
        );
        break;
    }

    emit(
      state.copyWith(
        isLoading: false,
        listChild: productDatas,
      ),
    );
  }

  _updateSortType(UpdateSortTypeEvent event, Emitter emit) {
    if (event.newType != state.sortType) {
      List<ShortProductDataModel> newList = List.from(state.listChild);

      switch (event.newType) {
        case BookSortType.bestSale:
          newList.sort(
            (a, b) => a.totalSold.compareTo(b.totalSold),
          );
          break;
        case BookSortType.descendingCost:
          newList.sort(
            (a, b) => a.price.compareTo(b.price),
          );
          break;

        case BookSortType.ascendingCost:
          newList.sort(
            (a, b) => b.price.compareTo(a.price),
          );
          break;
      }
      emit(state.copyWith(sortType: event.newType, listChild: newList));
    }
  }
}
