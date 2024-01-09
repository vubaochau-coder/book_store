import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/core/models/feedback_model.dart';
import 'package:book_store/screens/product_feedback/bloc/product_feedback_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'report_feedback_bottomsheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/convert.dart';

class FeedbackItem extends StatelessWidget {
  final FeedbackModel feedback;

  const FeedbackItem({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: feedback.userImg,
                  fit: BoxFit.contain,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feedback.userName,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18,
                                    child: buildRating(feedback.rating),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                Converter.convertDateToStringWithoutTime(
                                    feedback.dateSubmit),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: PopupMenuButton(
                            icon: const Icon(Icons.more_horiz, size: 16),
                            padding: EdgeInsets.zero,
                            position: PopupMenuPosition.under,
                            color: Colors.black.withOpacity(0.8),
                            elevation: 0,
                            onSelected: (value) {
                              if (value == 1) {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return const ReportFeedbackBottomSheet();
                                  },
                                ).then((value) {
                                  if (value != null) {
                                    context.read<ProductFeedbackBloc>().add(
                                          ReportFeedbackEvent(
                                            feedbackId: feedback.id,
                                            reportType: value,
                                          ),
                                        );
                                  }
                                });
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  value: 1,
                                  height: 32,
                                  child: Text(
                                    'Báo cáo bình luận',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ];
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feedback.review,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                feedback.isLike ? 'Người bán đã thích' : '',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(width: 4),
              Icon(
                feedback.isLike ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                color: feedback.isLike ? AppColors.themeColor : Colors.grey,
                size: 14,
              ),
            ],
          ),
          if (feedback.isReply)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(top: 4),
              width: double.infinity,
              color: const Color(0xfff5f5f5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phản hồi của Người bán',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    feedback.adminReply,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff595959),
                    ),
                  ),
                ],
              ),
            ),
        ],
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
