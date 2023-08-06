import 'package:book_store/custom_widgets/advertising_banner.dart';
import 'package:book_store/custom_widgets/product_item.dart';
import 'package:book_store/custom_widgets/search_bar.dart';
import 'package:book_store/models/advertising_model.dart';
import 'package:book_store/models/short_protduct_data_model.dart';
import 'package:book_store/screens/home/bloc/home_bloc.dart';
import 'package:book_store/screens/home/ui/category_list.dart';
import 'package:book_store/screens/home/ui/home_page_loading.dart';
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
    return Scaffold(
      backgroundColor: background,
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
        title: const MyCustomSearchBar(),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const HomePageLoading();
          } else if (state is HomeLoadingSuccessfulState) {
            return homePageSuccess(state.products, state.advertisements);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget homePageSuccess(
      List<ShortProductDataModel> data, List<AdvertisingDataModel> adData) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HomeBloc>(context).add(HomeLoadingEvent());
      },
      child: SingleChildScrollView(
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              child: SizedBox(
                height: 74,
                child: CategoryList(),
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
                return ProductItem(
                  data: data[index],
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
