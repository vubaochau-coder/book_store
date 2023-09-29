import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/core/models/feedback_model.dart';
import '../bloc/product_feedback_bloc.dart';
import 'feedback_empty_page.dart';
import 'feedback_loading_page.dart';
import 'sort_feedback_button.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductFeedbackPage extends StatelessWidget {
  final String productID;
  final List<FeedbackModel> allFeedback;

  const ProductFeedbackPage({
    super.key,
    required this.productID,
    required this.allFeedback,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductFeedbackBloc()
        ..add(
          ProductFeedbackLoadingEvent(
            bookID: productID,
            allFeedbacks: allFeedback,
          ),
        ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Đánh giá',
            style: AppTexts.appbarTitle,
          ),
          backgroundColor: AppColors.themeColor,
          elevation: 0,
          centerTitle: true,
          foregroundColor: AppColors.contentColor,
        ),
        body: BlocBuilder<ProductFeedbackBloc, ProductFeedbackState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const FeedbackLoadingPage();
            }

            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sắp xếp theo',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      SortFeedbackButton(),
                    ],
                  ),
                ),
                Expanded(
                  child: state.showedFeedbacks.isNotEmpty
                      ? ListView.separated(
                          itemCount: state.showedFeedbacks.length,
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
                                      imageUrl:
                                          state.showedFeedbacks[index].userImg,
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
                                              state.showedFeedbacks[index]
                                                  .userName,
                                            ),
                                            Text(
                                              Converter
                                                  .convertDateToStringWithoutTime(
                                                      state
                                                          .showedFeedbacks[
                                                              index]
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
                                          child: buildRating(state
                                              .showedFeedbacks[index].rating),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          state.showedFeedbacks[index].review,
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
          },
        ),
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
