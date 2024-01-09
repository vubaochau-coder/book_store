import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/core/models/feedback_model.dart';
import 'package:book_store/screens/product_feedback/ui/feedback_item.dart';
import '../bloc/product_feedback_bloc.dart';
import 'feedback_empty_page.dart';
import 'feedback_loading_page.dart';
import 'sort_feedback_button.dart';
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
                            return FeedbackItem(
                              feedback: state.showedFeedbacks[index],
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

  // Widget buildRating(double rating) {
  //   return ListView.builder(
  //     physics: const NeverScrollableScrollPhysics(),
  //     scrollDirection: Axis.horizontal,
  //     shrinkWrap: true,
  //     itemCount: 5,
  //     itemBuilder: (context, index) {
  //       return Icon(
  //         index <= (rating - 1) ? Icons.star : Icons.star_border,
  //         color: Colors.amber,
  //         size: 16,
  //       );
  //     },
  //   );
  // }
}
