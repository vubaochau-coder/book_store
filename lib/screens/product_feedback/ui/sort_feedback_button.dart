import 'package:book_store/screens/product_feedback/bloc/product_feedback_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortFeedbackButton extends StatelessWidget {
  const SortFeedbackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFeedbackBloc, ProductFeedbackState>(
      buildWhen: (previous, current) {
        return previous.sortType != current.sortType;
      },
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            dropdownStyleData: DropdownStyleData(
              offset: const Offset(0, 0),
              elevation: 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(height: 41),
            customButton: Container(
              constraints: const BoxConstraints(minWidth: 120),
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width -
                      (20 + 10 + 150 + 32 + 32),
                ),
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      convertEnumToString(state.sortType),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                BlocProvider.of<ProductFeedbackBloc>(context).add(
                  ProductFeedbackFilterEvent(sortType: value),
                );
              }
            },
            items: [
              ...FeedbackTypes.values.map(
                (e) => DropdownMenuItem(
                  value: e,
                  alignment: Alignment.center,
                  child: Text(
                    convertEnumToString(e),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String convertEnumToString(FeedbackTypes types) {
    String content = '';
    switch (types) {
      case FeedbackTypes.all:
        content = 'Tất cả';
        break;
      case FeedbackTypes.one:
        content = '1 sao';
        break;
      case FeedbackTypes.two:
        content = '2 sao';
        break;
      case FeedbackTypes.three:
        content = '3 sao';
        break;
      case FeedbackTypes.four:
        content = '4 sao';
        break;
      case FeedbackTypes.five:
        content = '5 sao';
        break;
    }
    return content;
  }
}
