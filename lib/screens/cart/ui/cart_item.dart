import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/core/models/cart_item_model.dart';
import 'package:book_store/screens/product_detail/ui/product_detail_page.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartData;
  final void Function(bool?) onSelected;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;
  final bool isSelected;

  const CartItem({
    super.key,
    required this.cartData,
    required this.onSelected,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Checkbox(
              activeColor: AppColors.themeColor,
              value: isSelected,
              onChanged: onSelected,
            ),
          ),
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteSlideTransition(
                    child: ProductDetailPage(productID: cartData.bookID),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: cartData.imgUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: baseShimmer,
                    highlightColor: highlightShimmer,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    cartData.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${Converter.convertNumberToMoney(cartData.price)} đ",
                      style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "${Converter.convertNumberToMoney(cartData.priceBeforeDiscount)} đ",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 32,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.grey[200],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: IconButton(
                                  onPressed: cartData.count > 1
                                      ? () => onDecrease()
                                      : null,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.remove, size: 20),
                                ),
                              ),
                              Container(
                                width: 48,
                                margin: const EdgeInsets.symmetric(vertical: 3),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  cartData.count.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: IconButton(
                                    onPressed: () => onIncrease(),
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.add, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: IconButton(
                            onPressed: onRemove,
                            padding: EdgeInsets.zero,
                            icon: const FaIcon(
                              FontAwesomeIcons.trashCan,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
