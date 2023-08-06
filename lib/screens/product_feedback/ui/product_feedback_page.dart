import 'package:book_store/screens/product_feedback/bloc/product_feedback_bloc.dart';
import 'package:book_store/screens/product_feedback/ui/feedback_empty_page.dart';
import 'package:book_store/screens/product_feedback/ui/feedback_loading_page.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductFeedbackPage extends StatelessWidget {
  final String productID;
  const ProductFeedbackPage({super.key, required this.productID});

  static List<String> sortType = [
    'Tất cả',
    '1 sao',
    '2 sao',
    '3 sao',
    '4 sao',
    '5 sao',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Đánh giá'),
        backgroundColor: themeColor,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<ProductFeedbackBloc, ProductFeedbackState>(
        bloc: BlocProvider.of<ProductFeedbackBloc>(context)
          ..add(ProductFeedbackLoadingEvent(sortOption: 0, bookID: productID)),
        builder: (context, state) {
          if (state is ProductFeedbackLoadingState) {
            return const FeedbackLoadingPage();
          } else if (state is ProductFeedbackLoadedState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sắp xếp theo',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 1,
                              color: Colors.grey,
                              offset: Offset(0, 1),
                            )
                          ],
                        ),
                        child: DropdownButtonFormField2(
                          value: sortType[state.sortType],
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
                            height: 32,
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
                            if (value != null &&
                                state.sortType != sortType.indexOf(value)) {
                              BlocProvider.of<ProductFeedbackBloc>(context).add(
                                ProductFeedbackLoadingEvent(
                                  sortOption: sortType.indexOf(value),
                                  bookID: productID,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.feedbacks.isNotEmpty
                      ? ListView.separated(
                          itemCount: state.feedbacks.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 4,
                              color: Colors.grey[100],
                            );
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, top: 6, bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl: state.feedbacks[index].userImg,
                                      fit: BoxFit.contain,
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.feedbacks[index].userName,
                                            ),
                                            Text(
                                              Converter
                                                  .convertDateToStringWithoutTime(
                                                      state.feedbacks[index]
                                                          .dateSubmit),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 18,
                                          child: buildRating(
                                              state.feedbacks[index].rating),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          state.feedbacks[index].review,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const FeedbackEmptyPage(),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }

  Widget buildRating(double rating) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Icon(
          index <= (rating - 1) ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      },
    );
  }
}
