import 'package:book_store/Category/SGKCategory/bloc/sgk_bloc.dart';
import 'package:book_store/Category/category_loading_state.dart';
import 'package:book_store/CustomWidget/product_item.dart';
import 'package:book_store/ProductDetail/ui/product_detail_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SGKCategoryPage extends StatelessWidget {
  const SGKCategoryPage({super.key});
  static List<String> sortType = [
    'Bán chạy nhất',
    'Giá giảm dần',
    'Giá tăng dần',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SgkBloc, SgkState>(
      builder: (context, state) {
        if (state is SgkLoadingSuccessfulState) {
          return successState(context, state);
        } else if (state is SgkLoadingState) {
          return const CategoryLoadingState();
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }

  Widget successState(BuildContext context, SgkLoadingSuccessfulState state) {
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
                BlocProvider.of<SgkBloc>(context)
                    .add(SgkLoadEvent(options: sortType.indexOf(value)));
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
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProductDetailPage(
                          productData: state.listSGK[index],
                        );
                      },
                    ),
                  );
                },
                child: ProductItem(
                  data: state.listSGK[index],
                ),
              );
            },
            itemCount: state.listSGK.length,
          ),
        ),
      ],
    );
  }
}