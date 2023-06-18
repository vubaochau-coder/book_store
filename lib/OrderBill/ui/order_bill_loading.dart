import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderBillLoading extends StatelessWidget {
  const OrderBillLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double space = 18;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          top: kToolbarHeight,
        ),
        child: Column(
          children: [
            Image.asset(
              'images/check.png',
              height: 108,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Đặt hàng thành công',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Center(
              child: Shimmer.fromColors(
                baseColor: baseShimmer,
                highlightColor: highlightShimmer,
                child: Container(
                  height: 30,
                  width: 144,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const SizedBox(
              width: 304,
              child: Text(
                'Cảm ơn vì đã đặt hàng trên IBOO\nBạn có thể theo dõi tình trạng đơn hàng trong mục Đơn hàng của tôi.',
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 24,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                child: Column(
                  children: [
                    Text(
                      'THÔNG TIN ĐƠN HÀNG',
                      style: TextStyle(
                        color: Colors.grey[850],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mã đơn hàng',
                          style: text1,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseShimmer,
                          highlightColor: highlightShimmer,
                          child: Container(
                            height: 18,
                            width: 144,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ngày đặt',
                          style: text1,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseShimmer,
                          highlightColor: highlightShimmer,
                          child: Container(
                            height: 18,
                            width: 84,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ngày giao (dự kiến)',
                          style: text1,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseShimmer,
                          highlightColor: highlightShimmer,
                          child: Container(
                            height: 18,
                            width: 84,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phí vận chuyển',
                          style: text1,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseShimmer,
                          highlightColor: highlightShimmer,
                          child: Container(
                            height: 18,
                            width: 84,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Giá sản phẩm',
                          style: text1,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseShimmer,
                          highlightColor: highlightShimmer,
                          child: Container(
                            height: 18,
                            width: 84,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng thanh toán',
                          style: text1,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseShimmer,
                          highlightColor: highlightShimmer,
                          child: Container(
                            height: 18,
                            width: 84,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trạng thái',
                          style: text1,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseShimmer,
                          highlightColor: highlightShimmer,
                          child: Container(
                            height: 18,
                            width: 84,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Trở về màn hình chính',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
