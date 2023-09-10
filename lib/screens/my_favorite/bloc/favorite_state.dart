part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  final List<FavoriteModel> listFavorite;
  final bool isLoading;

  const FavoriteState({
    this.listFavorite = const [],
    this.isLoading = false,
  });

  @override
  List<Object> get props => [listFavorite, isLoading];

  FavoriteState copyWith({
    bool? isLoading,
    List<FavoriteModel>? listFavorite,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      listFavorite: listFavorite ?? this.listFavorite,
    );
  }
}
