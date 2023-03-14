import 'package:book_store/CustomWidget/banner_quang_cao.dart';
import 'package:book_store/CustomWidget/product_item.dart';
import 'package:book_store/TrangChu/menu_category.dart';
import 'package:book_store/TrangChu/thong_tin_san_pham_page.dart';
import 'package:book_store/theme.dart';
import 'package:flutter/material.dart';

class TrangChuPage extends StatelessWidget {
  const TrangChuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        titleSpacing: 10,
        backgroundColor: themeColor,
        elevation: 0,
        leadingWidth: 62,
        leading: Container(
          margin: const EdgeInsets.only(left: 12),
          child: Image.asset(
            'images/logo_trans_crop.png',
            fit: BoxFit.contain,
          ),
        ),
        title: SizedBox(
          height: 36,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: themeColor,
                ),
                const Text(
                  'Tuổi trẻ đáng giá bao nhiêu',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 58,
                  margin: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffe65728),
                        Color(0xffffe341),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Tìm',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BannerQuangCao(
                  [
                    Image.asset(
                      'images/BookSales/bookSales_1.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/BookSales/bookSales_2.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/BookSales/bookSales_4.png',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/BookSales/bookSales_5.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/BookSales/bookSales_6.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/BookSales/bookSales_7.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/BookSales/bookSales_8.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/BookSales/bookSales_9.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'images/BookSales/bookSales_10.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: CategoriesMenu(),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 12,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 2,
              ),
              child: Text(
                'GỢI Ý CHO BẠN',
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const ThongTinSanPhamPage();
                        },
                      ),
                    );
                  },
                  child: const ProductItem(),
                );
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}
