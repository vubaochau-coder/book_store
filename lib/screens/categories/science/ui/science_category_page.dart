import 'package:book_store/custom_widgets/product_item.dart';
import 'package:book_store/screens/categories/category_loading_page.dart';
import 'package:book_store/screens/categories/science/bloc/science_bloc.dart';
import 'package:book_store/screens/categories/science/ui/science_sort_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceCategoryPage extends StatelessWidget {
  const ScienceCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 170,
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
          child: const ScienceSortButton(),
        ),
        Expanded(
          child: BlocBuilder<ScienceBloc, ScienceState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CategoryLoadingPage();
              }
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return ProductItem(
                    data: state.listScience[index],
                  );
                },
                itemCount: state.listScience.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
