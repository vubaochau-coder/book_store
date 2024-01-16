import 'package:book_store/custom_widgets/product_item.dart';
import 'package:book_store/screens/categories/child/bloc/child_bloc.dart';
import 'package:book_store/screens/categories/child/ui/child_sort_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../category_loading_page.dart';

class ChildCategoryPage extends StatelessWidget {
  const ChildCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 170,
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4),
          child: const ChildSortButton(),
        ),
        Expanded(
          child: BlocBuilder<ChildBloc, ChildState>(
            buildWhen: (previous, current) {
              return previous.isLoading != current.isLoading ||
                  previous.listChild != current.listChild;
            },
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
                    data: state.listChild[index],
                  );
                },
                itemCount: state.listChild.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
