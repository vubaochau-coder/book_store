import 'package:book_store/custom_widgets/product_item.dart';
import 'package:book_store/screens/categories/category_loading_page.dart';
import 'package:book_store/screens/categories/others/bloc/other_bloc.dart';
import 'package:book_store/screens/categories/others/ui/other_sort_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherCategoryPage extends StatelessWidget {
  const OtherCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 170,
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
          child: const OtherSortButton(),
        ),
        Expanded(
          child: BlocBuilder<OtherBloc, OtherState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CategoryLoadingPage();
              }
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return ProductItem(
                    data: state.listOther[index],
                  );
                },
                itemCount: state.listOther.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
