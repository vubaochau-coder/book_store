import 'package:book_store/custom_widgets/product_item.dart';
import 'package:book_store/screens/categories/child/bloc/child_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../category_loading_page.dart';

class ChildCategoryPage extends StatelessWidget {
  const ChildCategoryPage({super.key});

  static List<String> sortType = [
    'Bán chạy nhất',
    'Giá giảm dần',
    'Giá tăng dần',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildBloc, ChildState>(
      builder: (context, state) {
        if (state is ChildLoadingSuccessfulState) {
          return successState(context, state);
        } else if (state is ChildLoadingState) {
          return const CategoryLoadingPage();
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }

  Widget successState(BuildContext context, ChildLoadingSuccessfulState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: DropdownButtonFormField2(
            value: sortType[state.sortType],
            validator: (value) {
              if (value == null) {
                return 'Chọn';
              }
              return value;
            },
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            isExpanded: true,
            buttonStyleData: const ButtonStyleData(
              height: 28,
              padding: EdgeInsets.only(right: 8),
            ),
            items: sortType
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null && state.sortType != sortType.indexOf(value)) {
                BlocProvider.of<ChildBloc>(context).add(
                  ChildLoadEvent(
                    options: sortType.indexOf(value),
                  ),
                );
              }
            },
          ),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return ProductItem(
                data: state.listChild[index],
              );
            },
            itemCount: state.listChild.length,
          ),
        ),
      ],
    );
  }
}