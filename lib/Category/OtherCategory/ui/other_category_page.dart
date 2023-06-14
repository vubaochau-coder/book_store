import 'package:book_store/Category/OtherCategory/bloc/other_bloc.dart';
import 'package:book_store/Category/category_loading_state.dart';
import 'package:book_store/CustomWidget/product_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherCategoryPage extends StatelessWidget {
  const OtherCategoryPage({super.key});

  static List<String> sortType = [
    'Bán chạy nhất',
    'Giá giảm dần',
    'Giá tăng dần',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherBloc, OtherState>(
      builder: (context, state) {
        if (state is OtherLoadingSuccessfulState) {
          return successState(context, state);
        } else if (state is OtherLoadingState) {
          return const CategoryLoadingState();
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }

  Widget successState(BuildContext context, OtherLoadingSuccessfulState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          width: 160,
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null && state.sortType != sortType.indexOf(value)) {
                BlocProvider.of<OtherBloc>(context)
                    .add(OtherLoadEvent(options: sortType.indexOf(value)));
              }
            },
            onSaved: (newValue) {},
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
                data: state.listOther[index],
              );
            },
            itemCount: state.listOther.length,
          ),
        ),
      ],
    );
  }
}
