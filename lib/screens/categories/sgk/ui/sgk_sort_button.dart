import 'package:book_store/screens/categories/category_enum.dart';
import 'package:book_store/screens/categories/category_loading_dropdown.dart';
import 'package:book_store/screens/categories/sgk/bloc/sgk_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            menuItemStyleData: const MenuItemStyleData(height: 42),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black.withOpacity(0.8),
              ),
              elevation: 4,
              offset: const Offset(0, -5),
            ),
            buttonStyleData: const ButtonStyleData(
              height: 28,
              padding: EdgeInsets.only(right: 8),
            ),
            customButton: Container(
              constraints: const BoxConstraints(minWidth: 150, maxWidth: 400),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    CategoryTheme.convertBookSortType(state.sortType),
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            items: BookSortType.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        CategoryTheme.convertBookSortType(e),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                BlocProvider.of<SgkBloc>(context).add(
                  UpdateSortTypeEvent(newType: value),
                );
              }
            },
          ),
        );
      },
    );
  }
}
