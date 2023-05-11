import 'package:book_store/models/cart_item_model.dart';
import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutPage extends StatelessWidget {
  final List<CartItemModel> listProduct;
  const CheckoutPage({super.key, required this.listProduct});

  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Thanh toán'),
        foregroundColor: Colors.white,
        backgroundColor: themeColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                                  const Text('Địa chỉ giao hàng'),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.pin_drop_outlined,
                                    color: Colors.transparent,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Vũ Bảo Châu | (+84) 329788579\nKtx Khu B, Đường Nguyễn Du, Khu Phố 6 Phường Linh Trung, Thành Phố Thủ Đức, TP.Hồ Chí Minh',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listProduct.length,
                      itemBuilder: (context, index) {
                        return paymentItem(listProduct[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 8,
                          thickness: 2,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 246, 255, 254),
                      border: Border(
                        top: BorderSide(
                          color: Color.fromARGB(255, 198, 221, 218),
                        ),
                        bottom: BorderSide(
                          color: Color.fromARGB(255, 198, 221, 218),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.delivery_dining_outlined,
                              size: 20,
                              color: themeColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'Phương thức vận chuyển',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 24,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Text(
                                'Nhanh',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Text(
                              'đ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              Converter.convertNumberToMoney(8000),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          'Nhận hàng sau 3-5 ngày',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 48,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Text('Tin nhắn:'),
                        Expanded(
                          child: TextField(
                            controller: noteController,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Tin nhắn cho người bán...',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on_outlined,
                              size: 20,
                              color: themeColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'Phương thức thanh toán',
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
                              Icons.monetization_on_outlined,
                              size: 20,
                              color: Colors.transparent,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Thanh toán khi nhận hàng',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeColor,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: themeColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.assignment_outlined,
                              size: 20,
                              color: themeColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'Chi tiết thanh toán',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Tổng tiền hàng',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'đ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              Converter.convertNumberToMoney(
                                calculateTotalPrice(listProduct),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Phí vận chuyển',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'đ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              Converter.convertNumberToMoney(8000),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Giảm',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'đ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              Converter.convertNumberToMoney(8000),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Tổng thanh toán',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'đ',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: themeColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              Converter.convertNumberToMoney(8000),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: themeColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.library_books_outlined,
                          size: 20,
                          color: themeColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'Nhấn "Đặt hàng" đồng nghĩa với việc bạn đồng ý tuân theo ',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Điều khoản IBOO.',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                  child: Container(
                    padding: const EdgeInsets.only(right: 8),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Tổng thanh toán',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'đ',
                              style: TextStyle(
                                color: themeColor,
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              Converter.convertNumberToMoney(
                                  calculateTotalPrice(listProduct)),
                              style: TextStyle(
                                color: themeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                        'Đặt hàng',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
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

  double calculateTotalPrice(List<CartItemModel> list) {
    double result = 0;
    for (var item in list) {
      if (item.isSelected) {
        result += item.price * item.count;
      }
    }
    return result;
  }

  Widget paymentItem(CartItemModel item) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: CachedNetworkImage(
                imageUrl: item.imgUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'đ',
                        style: TextStyle(
                          color: themeColor,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        Converter.convertNumberToMoney(item.price),
                        style: TextStyle(
                          color: themeColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'x${item.count}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
