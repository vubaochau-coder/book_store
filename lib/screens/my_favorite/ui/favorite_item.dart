import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/models/favorite_model.dart';
import 'package:book_store/screens/cart/bloc/cart_bloc.dart';
import 'package:book_store/screens/my_favorite/bloc/favorite_bloc.dart';
import 'package:book_store/screens/product_detail/ui/product_detail_page.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavoriteItem extends StatelessWidget {
  final FavoriteModel favoriteModel;
  const FavoriteItem({super.key, required this.favoriteModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 124,
      //margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey,
            offset: Offset(0, 1),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteSlideTransition(
                    child:
                        ProductDetailPage(productID: favoriteModel.productID),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: favoriteModel.imgURL,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteSlideTransition(
                          child: ProductDetailPage(
                              productID: favoriteModel.productID),
                        ),
                      );
                    },
                    child: Text(
                      favoriteModel.productTitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'đ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 13,
                              color: themeColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            Converter.convertNumberToMoney(favoriteModel.price),
                            style: TextStyle(
                              fontSize: 13,
                              color: themeColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 34,
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<CartBloc>(context).add(
                                  CartAddItemEvent(
                                      itemID: favoriteModel.productID),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                backgroundColor: Colors.grey[350],
                                foregroundColor: Colors.white,
                                elevation: 0,
                              ),
                              child: const Text(
                                'Đặt mua ngay',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 34,
                            width: 34,
                            child: IconButton(
                              onPressed: () {
                                BlocProvider.of<FavoriteBloc>(context).add(
                                  FavoriteRemoveEvent(
                                      idDocument: favoriteModel.id),
                                );
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.trashCan,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
