import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/custom_widgets/product_item.dart';
import 'package:book_store/core/models/short_protduct_data_model.dart';
import 'package:book_store/screens/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultPage extends StatefulWidget {
  final String query;
  final List<ShortProductDataModel> listProducts;
  const SearchResultPage(
      {super.key, required this.listProducts, required this.query});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List<ShortProductDataModel> temp = [];

  @override
  void initState() {
    temp = List.from(widget.listProducts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SearchBloc>(context).add(SearchLoadingEvent());
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            '"${widget.query}"',
            style: AppTexts.appbarTitle.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          backgroundColor: AppColors.themeColor,
          foregroundColor: AppColors.contentColor,
          centerTitle: true,
          elevation: 0,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.filter_list),
              position: PopupMenuPosition.under,

              //constraints: const BoxConstraints.tightFor(width: 144),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onSelected: (value) {
                switch (value) {
                  case 'Bán chạy nhất':
                    setState(() {
                      temp = List.from(sortListByTotalSold());
                    });
                    break;
                  case 'Giá giảm dần':
                    setState(() {
                      temp = List.from(sortListByPrice(false));
                    });
                    break;
                  case 'Giá tăng dần':
                    setState(() {
                      temp = List.from(sortListByPrice(true));
                    });
                    break;
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'Bán chạy nhất',
                    height: 38,
                    child: Text(
                      'Bán chạy nhất',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Giá giảm dần',
                    height: 38,
                    child: Text(
                      'Giá giảm dần',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Giá tăng dần',
                    height: 38,
                    child: Text(
                      'Giá tăng dần',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ];
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Tìm kiếm ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '"${widget.query}"',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${widget.listProducts.length} kết quả',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            buildListProduct(temp, widget.query),
          ],
        ),
      ),
    );
  }

  List<ShortProductDataModel> sortListByPrice(bool ascending) {
    List<ShortProductDataModel> sorted = List.from(widget.listProducts);
    if (ascending) {
      sorted.sort(
        (a, b) {
          return a.price.compareTo(b.price);
        },
      );
    } else {
      sorted.sort(
        (a, b) {
          return b.price.compareTo(a.price);
        },
      );
    }
    return sorted;
  }

  List<ShortProductDataModel> sortListByTotalSold() {
    List<ShortProductDataModel> sorted = List.from(widget.listProducts);
    sorted.sort(
      (a, b) {
        return b.totalSold.compareTo(a.totalSold);
      },
    );
    return sorted;
  }

  Widget buildListProduct(List<ShortProductDataModel> products, String query) {
    if (products.isNotEmpty) {
      return Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return ProductItem(
              data: products[index],
            );
          },
          itemCount: products.length,
        ),
      );
    } else {
      return Expanded(
        child: Center(
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
                      'images/search.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                'Không tìm thấy kết quả cho "$query"',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
