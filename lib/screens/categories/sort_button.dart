import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/screens/categories/category_enum.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final BookSortType value;
  final Function(BookSortType) onChange;

  const SortButton({
    super.key,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                color: Colors.grey,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                CategoryTheme.convertBookSortType(value),
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontSize: 14,
                ),
                maxLines: 1,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.themeColor,
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
            onChange(value);
          }
        },
      ),
    );
  }
}
