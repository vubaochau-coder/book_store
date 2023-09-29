import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/feedback_model.dart';
import 'package:book_store/core/models/product_data_model.dart';
import 'package:book_store/core/repositories/book_repository.dart';
import 'package:book_store/core/repositories/favorite_repository.dart';
import 'package:book_store/core/repositories/feedback_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final BookRepository _bookRepository;
  final FeedbackRepository _feedbackRepository;
  final FavoriteRepository _favoriteRepository;

  ProductBloc(
      this._bookRepository, this._feedbackRepository, this._favoriteRepository)
      : super(const ProductState()) {
    on<ProductLoadingEvent>(_onLoading);
    on<ProductFavoriteEvent>(_onFavorite);
  }

  _onLoading(ProductLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    final futureGroup = await Future.wait([
      _bookRepository.getBookInfo(event.idProduct),
      _favoriteRepository.isBookFavorited(event.idProduct),
      _feedbackRepository.getAllFeedback(event.idProduct),
    ]);

    List<FeedbackModel> limit = [];

    List<FeedbackModel> allFeedbacks = futureGroup[2] as List<FeedbackModel>;
    if (allFeedbacks.length >= 3) {
      limit = allFeedbacks.sublist(0, 3);
    } else {
      limit = List.from(allFeedbacks);
    }

    emit(state.copyWith(
      isLoading: false,
      isFavorited: futureGroup[1] as bool,
      feedbacks: limit,
      productData: futureGroup[0] as ProductDataModel,
      allFeedbacks: allFeedbacks,
    ));
  }

  _onFavorite(ProductFavoriteEvent event, Emitter emit) async {
    if (state.isFavorited) {
      await _favoriteRepository
          .unFavoriteByBookId(event.idProduct)
          .then((value) {
        Fluttertoast.showToast(msg: 'Bỏ thích sản phẩm thành công');
        emit(state.copyWith(isFavorited: false));
      });
    } else {
      await _favoriteRepository.addFavoriteBook(event.idProduct).then((value) {
        Fluttertoast.showToast(msg: 'Đã thêm sản phẩm vào mục Yêu thích');
        emit(state.copyWith(isFavorited: true));
      });
    }
  }
}
