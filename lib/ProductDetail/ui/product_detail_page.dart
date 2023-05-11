import 'package:book_store/Cart/bloc/cart_bloc.dart';
import 'package:book_store/ProductDetail/bloc/product_bloc.dart';
import 'package:book_store/ProductDetail/ui/product_images.dart';
import 'package:book_store/ProductDetail/ui/star_point.dart';
import 'package:book_store/models/product_data_model.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productData});

  final ProductDataModel productData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: themeColor,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: kToolbarHeight,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      ProductImagesSlider(imgUrls: productData.imageURL),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                          left: 14,
                          right: 14,
                          top: 10,
                          bottom: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productData.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${Converter.convertNumberToMoney(productData.price - productData.price * productData.discount)} ",
                                  style: TextStyle(
                                    color: themeColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'đ',
                                  style: TextStyle(
                                    color: themeColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "${Converter.convertNumberToMoney(productData.price)} ",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'đ',
                                  style: TextStyle(
                                    decoration: TextDecoration.combine(
                                      [
                                        TextDecoration.lineThrough,
                                        TextDecoration.underline,
                                      ],
                                    ),
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: Colors.red[50],
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.red,
                                    ),
                                  ),
                                  child: Text(
                                    '-${(productData.discount * 100).toStringAsFixed(0)}%',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                StarPoint(star: productData.star),
                                Text(
                                  productData.star.toStringAsFixed(1),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${NumberFormat("###,##0").format(productData.totalSold)} lượt bán',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 12,
                                bottom: 8,
                              ),
                              child: Text(
                                'THÔNG TIN SẢN PHẨM',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 8,
                                bottom: 2,
                              ),
                              child: Column(
                                children: [
                                  DefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                    child: Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 6),
                                              child: Text(
                                                'Tác giả',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6),
                                              child: Text(productData.author),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 6),
                                              child: Text('NXB'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6),
                                              child:
                                                  Text(productData.publisher),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 6),
                                              child: Text('Năm XB'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6),
                                              child: Text(
                                                  productData.publishingYear),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ExpandableText(
                                    productData.description
                                        .replaceAll('\n', '\n'),
                                    expandText: 'Xem thêm',
                                    collapseText: 'Ẩn bớt',
                                    maxLines: 4,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 8),
                        padding: const EdgeInsets.only(bottom: 6),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 12,
                                bottom: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'ĐÁNH GIÁ TỪ KHÁCH HÀNG',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '0 nhận xét',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 8,
                                bottom: 2,
                              ),
                              child: Center(
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.edit_note_sharp,
                                      size: 68,
                                    ),
                                    Text(
                                      'Hiện chưa có nhận xét nào về sản phẩm này',
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
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
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(CartAddItemEvent(itemID: productData.id));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: themeColor,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Thêm vào giỏ hàng',
                                style: TextStyle(
                                  color: themeColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
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
                            'Đặt mua ngay',
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
      },
    );
  }
}
