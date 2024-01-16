import 'package:book_store/custom_widgets/product_item.dart';
import 'package:book_store/screens/categories/category_loading_page.dart';
import 'package:book_store/screens/categories/literature/bloc/literature_bloc.dart';
import 'package:book_store/screens/categories/literature/ui/literature_sort_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiteratureCategoryPage extends StatelessWidget {
  const LiteratureCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 170,
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4),
          child: const LiteratureSortButton(),
        ),
        Expanded(
          child: BlocBuilder<LiteratureBloc, LiteratureState>(
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
                    data: state.listLiterature[index],
                  );
                },
                itemCount: state.listLiterature.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
