import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingAddress extends StatelessWidget {
  const LoadingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.only(top: 4),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.pin_drop_outlined,
                      color: themeColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'Địa chỉ giao hàng',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.pin_drop_outlined,
                      color: Colors.transparent,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[200]!,
                        child: Container(
                          color: Colors.white,
                          child: const Text(
                            'Vũ Bảo Châu | (+84) 329788579\nKtx Khu B, Đường Nguyễn Du, Khu Phố 6 Phường Linh Trung, Thành Phố Thủ Đức, TP.Hồ Chí Minh',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
