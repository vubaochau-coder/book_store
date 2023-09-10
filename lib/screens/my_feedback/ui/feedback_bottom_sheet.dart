import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/models/unfeedback_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class FeedbackBottomSheet extends StatefulWidget {
  final FeedbackItemModel itemModel;
  final void Function(double rating, String review) onSubmit;
  const FeedbackBottomSheet(
      {super.key, required this.itemModel, required this.onSubmit});

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  double userRating = 5;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.remove,
              color: Colors.black,
            ),
            const Text(
              'Sản phẩm',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 18, bottom: 18),
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: widget.itemModel.imgURL,
                      fit: BoxFit.contain,
                      height: 72,
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                          baseColor: AppColors.baseShimmer,
                          highlightColor: AppColors.highlightShimmer,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.itemModel.bookTitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'Đánh giá của bạn',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            RatingBar(
              initialRating: userRating,
              minRating: 1,
              maxRating: 5,
              allowHalfRating: false,
              glow: false,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemSize: 44,
              onRatingUpdate: (value) {
                userRating = value;
              },
              ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.amber,
                ),
                empty: const Icon(
                  Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Hãy chia sẻ cảm nhận của bạn'),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              maxLength: 200,
              maxLines: 5,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              style: AppTexts.inputTextStyle,
              decoration: InputDecoration(
                hintText: 'Bạn thấy chất lượng sản phẩm thế nào?',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () => {
                  if (textController.text.trim().isNotEmpty)
                    {
                      widget.onSubmit(userRating, textController.text.trim()),
                      Navigator.of(context).pop()
                    }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Hoàn tất'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
