import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/models/transaction_model.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

abstract class AbstractTransactionItem extends StatelessWidget {
  final VoidCallback onTap;
  final TransactionModel transactionData;
  const AbstractTransactionItem({
    super.key,
    required this.onTap,
    required this.transactionData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            color: Colors.grey[200]!,
          ),
          right: BorderSide(
            color: Colors.grey[200]!,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.grey[300],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/logo_text_pg.png',
                        fit: BoxFit.contain,
                        height: 12,
                      ),
                      const Spacer(),
                      buildStatus(),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 0,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 88,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 84,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[400]!,
                              width: 1,
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: transactionData.products[0].imgUrl,
                            placeholder: (context, url) {
                              return Shimmer.fromColors(
                                baseColor: AppColors.baseShimmer,
                                highlightColor: AppColors.highlightShimmer,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              );
                            },
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                transactionData.products[0].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'x${transactionData.products[0].count}',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'đ',
                                    style: TextStyle(
                                      decoration: TextDecoration.combine(
                                        [
                                          TextDecoration.lineThrough,
                                          TextDecoration.underline,
                                        ],
                                      ),
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    Converter.convertNumberToMoney(
                                        transactionData
                                            .products[0].priceBeforeDiscount),
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'đ',
                                    style: TextStyle(
                                      color: AppColors.themeColor,
                                      decoration: TextDecoration.underline,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    Converter.convertNumberToMoney(
                                        transactionData.products[0].price),
                                    style: TextStyle(
                                      color: AppColors.themeColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        '${productCount(transactionData.products)} sản phẩm',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Tổng thanh toán: ',
                      ),
                      Text(
                        'đ',
                        style: TextStyle(
                          color: AppColors.themeColor,
                          decoration: TextDecoration.underline,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        Converter.convertNumberToMoney(
                            transactionData.totalPrice),
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 0,
                ),
                buildAction(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStatus();
  Widget buildAction();

  int productCount(List<CartItemModel> products) {
    int result = 0;
    for (var item in products) {
      result += item.count;
    }
    return result;
  }
}
