import 'package:book_store/screens/categories/category_loading_dropdown.dart';
import 'package:book_store/screens/categories/sgk/bloc/sgk_bloc.dart';
import 'package:book_store/screens/categories/sort_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SgkSortButton extends StatelessWidget {
  const SgkSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SgkBloc, SgkState>(
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
            BlocProvider.of<SgkBloc>(context).add(
              UpdateSortTypeEvent(newType: p0),
            );
          },
        );
      },
    );
  }
}
