import 'package:book_store/screens/categories/category_loading_dropdown.dart';
import 'package:book_store/screens/categories/child/bloc/child_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../sort_button.dart';

class ChildSortButton extends StatelessWidget {
  const ChildSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildBloc, ChildState>(
      buildWhen: (previous, current) {
        return previous.sortType != current.sortType ||
            previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const CategoryLoadingDropdown();
        }
        return SortButton(
          value: state.sortType,
          onChange: (p0) {
            BlocProvider.of<ChildBloc>(context).add(
              UpdateSortTypeEvent(newType: p0),
            );
          },
        );
      },
    );
  }
}
