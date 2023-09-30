import 'package:book_store/screens/categories/category_loading_dropdown.dart';
import 'package:book_store/screens/categories/others/bloc/other_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../sort_button.dart';

class OtherSortButton extends StatelessWidget {
  const OtherSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherBloc, OtherState>(
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
            BlocProvider.of<OtherBloc>(context).add(
              UpdateSortTypeEvent(newType: p0),
            );
          },
        );
      },
    );
  }
}
