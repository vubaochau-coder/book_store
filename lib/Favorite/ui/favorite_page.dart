import 'package:book_store/Favorite/bloc/favorite_bloc.dart';
import 'package:book_store/Favorite/ui/favorite_item.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Yêu thích'),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        bloc: BlocProvider.of<FavoriteBloc>(context)
          ..add(FavoriteLoadingEvent()),
        builder: (context, state) {
          if (state is FavoriteLoadingState) {
            return Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: themeColor,
                size: 60,
              ),
            );
          } else if (state is FavoriteLoadingSuccessfulState) {
            return Padding(
              padding: const EdgeInsets.only(top: 4, left: 2, right: 2),
              child: ListView.separated(
                itemCount: state.listFavorite.length,
                itemBuilder: (context, index) {
                  return FavoriteItem(
                    favoriteModel: state.listFavorite[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 4,
                  );
                },
              ),
            );
          } else if (state is FavoriteEmptyState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 112,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.6,
                        image: AssetImage(
                          'images/clipboard.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Text(
                    'Không có sản phẩm',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
