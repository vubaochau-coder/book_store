import 'package:book_store/app_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EditProfileLoading extends StatelessWidget {
  const EditProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            const SizedBox(height: 250),
            Image.asset(
              'images/background.jpg',
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Shimmer.fromColors(
                baseColor: AppColors.baseShimmer,
                highlightColor: AppColors.highlightShimmer,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, top: 28),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text(
                      'Tên của bạn',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                emptyContainer(),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text(
                      'Số điện thoại',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                emptyContainer(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColors.baseShimmer,
                            highlightColor: AppColors.highlightShimmer,
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Text(
                                'Giới tính',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          emptyContainer(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColors.baseShimmer,
                            highlightColor: AppColors.highlightShimmer,
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Text(
                                'Ngày sinh',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          emptyContainer(),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const Spacer(),
        Container(
          width: double.infinity,
          height: 48,
          margin: const EdgeInsets.only(bottom: 14, left: 6, right: 6),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Cập nhật',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget emptyContainer() {
    return Container(
      height: 48,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8, bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey, width: 1),
      ),
    );
  }
}
