import 'package:book_store/UserFeedback/bloc/user_feedback_bloc.dart';
import 'package:book_store/UserFeedback/ui/feedback_bottom_sheet.dart';
import 'package:book_store/UserFeedback/ui/feedback_empty_page.dart';
import 'package:book_store/UserFeedback/ui/feedback_item.dart';
import 'package:book_store/Transaction/ui/transaction_loading.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFeedbackBloc, UserFeedbackState>(
      bloc: BlocProvider.of<UserFeedbackBloc>(context)
        ..add(UserFeedbackLoadingEvent()),
      builder: (context, state) {
        if (state is UserFeedbackLoadingState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text('Đánh giá sản phẩm'),
            ),
            body: const TransactionLoadingPage(),
          );
        } else if (state is UserFeedbackEmptyState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text('Đánh giá sản phẩm'),
            ),
            body: const FeedbackEmptyPage(),
          );
        } else if (state is UserFeedbackLoadingSuccessfulState) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: background,
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  title: const Text('Đánh giá sản phẩm'),
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  child: ListView.separated(
                    itemCount: state.listFeedback.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: FeedbackBottomSheet(
                                  itemModel: state.listFeedback[index],
                                  onSubmit: (rating, review) {
                                    BlocProvider.of<UserFeedbackBloc>(context)
                                        .add(
                                      UserFeedbackSubmitEvent(
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
                        child:
                            FeedbackItem(itemModel: state.listFeedback[index]),
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
              state.isLoading ? progressDialogue(context) : const SizedBox(),
            ],
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text('Đánh giá sản phẩm'),
            ),
            body: const Center(
              child: Text('Something went wrong'),
            ),
          );
        }
      },
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
