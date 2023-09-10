import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/screens/my_favorite/bloc/favorite_bloc.dart';
import 'package:book_store/screens/my_favorite/ui/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc()..add(FavoriteLoadingEvent()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Yêu thích',
            style: AppTexts.appbarTitle,
          ),
          backgroundColor: AppColors.themeColor,
          foregroundColor: AppColors.contentColor,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: LoadingAnimationWidget.horizontalRotatingDots(
                  color: AppColors.themeColor,
                  size: 60,
                ),
              );
            }

            if (state.listFavorite.isEmpty) {
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
            }

            return ListView.separated(
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
            );
          },
        ),
      ),
    );
  }
}
