part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteLoadingSuccessfulState extends FavoriteState {
  final List<FavoriteModel> listFavorite;

  const FavoriteLoadingSuccessfulState({required this.listFavorite});
  @override
  List<Object> get props => [listFavorite];
}

class FavoriteEmptyState extends FavoriteState {}
