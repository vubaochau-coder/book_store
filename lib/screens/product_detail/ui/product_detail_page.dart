import 'package:book_store/custom_widgets/custom_page_route.dart';
import 'package:book_store/core/models/cart_item_model.dart';
import 'package:book_store/screens/cart/bloc/cart_bloc.dart';
import 'package:book_store/screens/checkout/ui/checkout_page.dart';
import 'package:book_store/screens/product_detail/bloc/product_bloc.dart';
import 'package:book_store/screens/product_detail/ui/comment.dart';
import 'package:book_store/screens/product_detail/ui/product_description.dart';
import 'package:book_store/screens/product_detail/ui/product_detail_loading.dart';
import 'package:book_store/screens/product_detail/ui/product_header.dart';
import 'package:book_store/screens/product_detail/ui/product_images.dart';
import 'package:book_store/screens/product_feedback/ui/product_feedback_page.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productID});

  final String productID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context)
        ..add(ProductLoadingEvent(idProduct: productID)),
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return const ProductDetailLoadingPage();
        } else if (state is ProductLoadingSuccesfulSatte) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: themeColor,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(ProductFavoriteEvent(idProduct: productID));
                  },
                  icon: Icon(state.isFavorited
                      ? Icons.favorite
                      : Icons.favorite_border),
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
                        ProductImagesSlider(
                            imgUrls: state.productData.imageURL),
                        ProductHeader(
                          title: state.productData.title,
                          price: state.productData.price,
                          discount: state.productData.discount,
                          totalFeedback: state.totalFeedback,
                          totalSold: state.productData.totalSold,
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
                              ProductDescription(
                                author: state.productData.author,
                                publisher: state.productData.publisher,
                                publishingYear:
                                    state.productData.publishingYear,
                                description: state.productData.description,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteSlideTransition(
                                            child: ProductFeedbackPage(
                                              productID: productID,
                                            ),
                                          ),
                                        );
                                      },
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: themeColor,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Xem thêm',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: themeColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: themeColor,
                                                size: 12,
                                              ),
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
                                height: 2,
                              ),
                              CommentList(feedbacks: state.feedbacks),
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
                              BlocProvider.of<CartBloc>(context).add(
                                CartAddItemEvent(
                                  itemID: state.productData.id,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: splashColor,
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
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteSlideTransition(
                                  child: CheckoutPage(
                                    listProduct: [
                                      CartItemModel(
                                        id: '',
                                        bookID: state.productData.id,
                                        count: 1,
                                        price: state.productData.price -
                                            state.productData.price *
                                                state.productData.discount,
                                        imgUrl: state.productData.imageURL[0],
                                        title: state.productData.title,
                                        priceBeforeDiscount:
                                            state.productData.price,
                                      ),
                                    ],
                                    checkoutFromCart: false,
                                  ),
                                ),
                              );
                            },
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
                                fontSize: 15,
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
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        }
      },
    );
  }
}
