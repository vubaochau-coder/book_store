import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/screens/my_feedback/bloc/my_feedback_bloc.dart';
import 'package:book_store/screens/my_feedback/ui/feedback_bottom_sheet.dart';
import 'package:book_store/screens/my_feedback/ui/feedback_empty_page.dart';
import 'package:book_store/screens/my_feedback/ui/my_feedback_item.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyFeedbackPage extends StatelessWidget {
  const MyFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyFeedbackBloc()..add(MyFeedbackLoadingEvent()),
      child: BlocBuilder<MyFeedbackBloc, MyFeedbackState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Scaffold(
              appBar: buildAppBar(context),
              body: const TransactionLoadingPage(),
            );
          }

          if (state.listFeedback.isEmpty) {
            return Scaffold(
              appBar: buildAppBar(context),
              body: const FeedbackEmptyPage(),
            );
          }

          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.background,
                appBar: buildAppBar(context),
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListView.separated(
                    itemCount: state.listFeedback.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            builder: (newContext) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(newContext)
                                        .viewInsets
                                        .bottom),
                                child: FeedbackBottomSheet(
                                  itemModel: state.listFeedback[index],
                                  onSubmit: (rating, review) {
                                    BlocProvider.of<MyFeedbackBloc>(context)
                                        .add(
                                      MyFeedbackSubmitEvent(
                                        feedbackID:
                                            state.listFeedback[index].id,
                                        bookID:
                                            state.listFeedback[index].bookID,
                                        review: review,
                                        rating: rating,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: MyFeedbackItem(
                            itemModel: state.listFeedback[index]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                  ),
                ),
              ),
              state.showLoadingDialog
                  ? progressDialogue(context)
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themeColor,
      foregroundColor: AppColors.contentColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Đánh giá sản phẩm',
        style: AppTexts.appbarTitle,
      ),
    );
  }

  Widget progressDialogue(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: LoadingAnimationWidget.fourRotatingDots(
        color: Colors.white,
        size: 80,
      ),
    );
  }
}
