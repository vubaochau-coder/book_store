import 'package:book_store/models/feedback_model.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentList extends StatelessWidget {
  final List<FeedbackModel> feedbacks;
  const CommentList({super.key, required this.feedbacks});

  @override
  Widget build(BuildContext context) {
    return feedbacks.isEmpty
        ? const Padding(
            padding: EdgeInsets.only(
              left: 14,
              right: 14,
              top: 8,
              bottom: 2,
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.edit_note_sharp,
                    size: 68,
                  ),
                  Text(
                    'Hiện chưa có nhận xét nào về sản phẩm này',
                  ),
                ],
              ),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            itemCount: feedbacks.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const Divider(
                height: 8,
                thickness: 2,
                indent: 12,
                endIndent: 12,
              );
            },
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: feedbacks[index].userImg,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                feedbacks[index].userName,
                              ),
                              Text(
                                Converter.convertDateToStringWithoutTime(
                                  feedbacks[index].dateSubmit,
                                ),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                            child: buildRating(feedbacks[index].rating),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            feedbacks[index].review,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
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
