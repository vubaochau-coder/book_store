import 'package:book_store/CustomWidget/advertising_banner.dart';
import 'package:book_store/CustomWidget/product_item.dart';
import 'package:book_store/Home/bloc/home_bloc.dart';
import 'package:book_store/Home/ui/category.dart';
import 'package:book_store/Home/ui/product_detail_page.dart';
import 'package:book_store/models/advertising_model.dart';
import 'package:book_store/models/category_model.dart';
import 'package:book_store/models/product_data_model.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return homePageLoading();
        } else if (state is HomeLoadingSuccessfulState) {
          return homePageSuccess(state.products, state.advertisements);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget homePageLoading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget homePageSuccess(
      List<ProductDataModel> data, List<AdvertisingDataModel> adData) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        titleSpacing: 10,
        backgroundColor: themeColor,
        elevation: 0,
        leadingWidth: 62,
        leading: Container(
          margin: const EdgeInsets.only(left: 12),
          child: Image.asset(
            'images/logo_trans_crop.png',
            fit: BoxFit.contain,
          ),
        ),
        title: SizedBox(
          height: 36,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: themeColor,
                ),
                const Text(
                  'Tuổi trẻ đáng giá bao nhiêu',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 58,
                  margin: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffe65728),
                        Color(0xffffe341),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Tìm',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BannerQuangCao(
                  datas: adData,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              child: SizedBox(
                height: 74,
                child: ListView.builder(
                  itemCount: Category.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => null,
                      child: CategorieItem(
                        categoryData: Category.categories[index],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 12,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 2,
              ),
              child: Text(
                'GỢI Ý CHO BẠN',
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProductDetailPage(
                            productData: data[index],
                          );
                        },
                      ),
                    );
                  },
                  child: ProductItem(
                    data: data[index],
                  ),
                );
              },
              itemCount: data.length,
            ),
          ],
        ),
      ),
    );
  }
}
