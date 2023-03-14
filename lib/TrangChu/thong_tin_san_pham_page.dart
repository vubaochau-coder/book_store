import 'package:book_store/theme.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class ThongTinSanPhamPage extends StatelessWidget {
  const ThongTinSanPhamPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String longText =
        'Tuổi Trẻ Đáng Giá Bao Nhiêu\n"Bạn hối tiếc vì không nắm bắt lấy một cơ hội nào đó, chẳng có ai phải mất ngủ.\nBạn trải qua những ngày tháng nhạt nhẽo với công việc bạn căm ghét, người ta chẳng hề bận lòng.\nBạn có chết mòn nơi xó tường với những ước mơ dang dở, đó không phải là việc của họ.\nSuy cho cùng, quyết định là ở bạn. Muốn có điều gì hay không là tùy bạn.\nNên hãy làm những điều bạn thích. Hãy đi theo tiếng nói trái tim. Hãy sống theo cách bạn cho là mình nên sống.\nVì sau tất cả, chẳng ai quan tâm."\nNhận định\n"Tôi đã đọc quyển sách này một cách thích thú. Có nhiều kiến thức và kinh nghiệm hữu ích, những điều mới mẻ ngay cả với người gần trung niên như tôi.\nTuổi trẻ đáng giá bao nhiêu? được tác giả chia làm 3 phần: HỌC, LÀM, ĐI.\nNhưng tôi thấy cuốn sách còn thể hiện một phần thứ tư nữa, đó là ĐỌC.\nHãy đọc sách, nếu bạn đọc sách một cách bền bỉ, sẽ đến lúc bạn bị thôi thúc không ngừng bởi ý muốn viết nên cuốn sách của riêng mình.\nNếu tôi còn ở tuổi đôi mươi, hẳn là tôi sẽ đọc Tuổi trẻ đáng giá bao nhiêu? nhiều hơn một lần."\n(Đặng Nguyễn Đông Vy, tác giả, nhà báo)';
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 2 -
                            MediaQuery.of(context).padding.top -
                            kBottomNavigationBarHeight,
                        width: double.infinity,
                        padding: const EdgeInsets.all(2),
                        child: Image.asset(
                          'images/product.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 14,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          child: const Text(
                            '1/6',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                      top: 10,
                      bottom: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sách tuổi trẻ đáng giá bao nhiêu?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              '65.000 ',
                              style: TextStyle(
                                color: themeColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'đ',
                              style: TextStyle(
                                color: themeColor,
                                decoration: TextDecoration.underline,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '80.000 ',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey[600],
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'đ',
                              style: TextStyle(
                                decoration: TextDecoration.combine(
                                  [
                                    TextDecoration.lineThrough,
                                    TextDecoration.underline,
                                  ],
                                ),
                                color: Colors.grey[600],
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: const Text(
                                '-20%',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const Icon(
                              Icons.star_half_outlined,
                              color: Colors.amber,
                              size: 18,
                            ),
                            Text(
                              '4,8',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '1.514 lượt bán',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 14,
                            right: 14,
                            top: 12,
                            bottom: 8,
                          ),
                          child: Text(
                            'THÔNG TIN SẢN PHẨM',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 14,
                            top: 8,
                            bottom: 2,
                          ),
                          child: Column(
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                                child: Table(
                                  children: const [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            'Tác giả',
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 6),
                                          child: Text('Rosie Nguyễn'),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 6),
                                          child: Text('NXB'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 6),
                                          child: Text('NXB Hội Nhà Văn'),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 6),
                                          child: Text('Năm XB'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 6),
                                          child: Text('11/2016'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ExpandableText(
                                longText,
                                expandText: 'Xem thêm',
                                collapseText: 'Ẩn bớt',
                                maxLines: 4,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 8),
                    padding: const EdgeInsets.only(bottom: 6),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 14,
                            top: 12,
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'ĐÁNH GIÁ TỪ KHÁCH HÀNG',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                '867 nhận xét',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 14,
                            top: 8,
                            bottom: 2,
                          ),
                          child: Center(
                            child: Column(
                              children: const [
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: themeColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Thêm vào giỏ hàng',
                            style: TextStyle(
                              color: themeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        'Đặt mua ngay',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
