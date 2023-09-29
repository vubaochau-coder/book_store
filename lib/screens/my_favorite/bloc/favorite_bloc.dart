import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/favorite_model.dart';
import 'package:book_store/core/repositories/favorite_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  StreamSubscription? _favoriteStream;
  final FavoriteRepository _favoriteRepository;

  FavoriteBloc(this._favoriteRepository) : super(const FavoriteState()) {
    on<FavoriteLoadingEvent>(_onLoading);
    on<FavoriteRemoveEvent>(_onRemove);
    on<FavoriteUpdateEvent>(_onUpdate);
    on<FavoriteUpdateEmptyEvent>(_onUpdateEmpty);
  }

  @override
  Future<void> close() async {
    _favoriteStream?.cancel();
    _favoriteStream = null;
    super.close();
  }

  _onLoading(FavoriteLoadingEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));

    _favoriteStream =
        _favoriteRepository.favoriteStream().listen((snapshotEvent) async {
      if (snapshotEvent.docs.isNotEmpty) {
        final allBooks = await Future.wait([
          ...snapshotEvent.docs.map(
            (e) => _favoriteRepository.getFavoriteBook(
              e.id,
              e.data()['productID'],
            ),
          )
        ]);

        add(FavoriteUpdateEvent(listFavorite: allBooks));
      } else {
        add(FavoriteUpdateEmptyEvent());
      }
    });
  }

  _onRemove(FavoriteRemoveEvent event, Emitter emit) async {
    await _favoriteRepository
        .unFavoriteByFavoriteId(event.idDocument)
        .then((value) {
      Fluttertoast.showToast(msg: 'Bỏ thích sản phẩm thành công');
    });
  }

  _onUpdate(FavoriteUpdateEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        listFavorite: event.listFavorite,
      ),
    );
  }

  _onUpdateEmpty(FavoriteUpdateEmptyEvent event, Emitter emit) {
    emit(
      state.copyWith(
        isLoading: false,
        listFavorite: [],
      ),
    );
  }
}
