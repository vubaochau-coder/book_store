part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FavoriteLoadingEvent extends FavoriteEvent {}

class FavoriteRemoveEvent extends FavoriteEvent {
  final String idDocument;

  const FavoriteRemoveEvent({required this.idDocument});
}

class FavoriteUpdateEvent extends FavoriteEvent {
  final List<FavoriteModel> listFavorite;

  const FavoriteUpdateEvent({required this.listFavorite});
}

class FavoriteUpdateEmptyEvent extends FavoriteEvent {}
