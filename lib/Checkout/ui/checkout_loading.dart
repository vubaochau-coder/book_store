import 'package:book_store/Checkout/ui/address_loading.dart';
import 'package:book_store/Checkout/ui/checkout_item.dart';
import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutLoading extends StatelessWidget {
  final List<CartItemModel> listProduct;
  const CheckoutLoading({super.key, required this.listProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Thanh toán'),
        foregroundColor: Colors.white,
        backgroundColor: themeColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const LoadingAddress(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: themeColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'Sản phẩm',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 12,
                          thickness: 1,
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listProduct.length,
                          itemBuilder: (context, index) {
                            return CheckoutItem(data: listProduct[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 8,
                              thickness: 1,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 246, 255, 254),
                      border: Border(
                        top: BorderSide(
                          color: Color.fromARGB(255, 198, 221, 218),
                        ),
                        bottom: BorderSide(
                          color: Color.fromARGB(255, 198, 221, 218),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.delivery_dining_outlined,
                              size: 20,
                              color: themeColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'Phương thức vận chuyển',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 24,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: baseShimmer,
                              highlightColor: highlightShimmer,
                              child: Container(
                                width: 88,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Shimmer.fromColors(
                              baseColor: baseShimmer,
                              highlightColor: highlightShimmer,
                              child: Container(
                                width: 88,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseShimmer,
                          highlightColor: highlightShimmer,
                          child: Container(
                            width: 176,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: baseShimmer,
                    highlightColor: highlightShimmer,
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(right: 8),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Tổng thanh toán',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseShimmer,
                          highlightColor: highlightShimmer,
                          child: Container(
                            width: 104,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        'Đặt hàng',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
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
