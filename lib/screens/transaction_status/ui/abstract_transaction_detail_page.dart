import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/core/models/transaction_model.dart';
import 'package:book_store/screens/transaction_status/ui/body_content.dart';
import 'package:book_store/screens/transaction_status/ui/header_content.dart';
import 'package:book_store/screens/transaction_status/ui/transaction_product.dart';
// import 'package:book_store/theme.dart';
import 'package:book_store/utils/convert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class AbstractTransactionDetailPage extends StatelessWidget {
  final TransactionModel transactionData;
  const AbstractTransactionDetailPage(
      {super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Chi tiết đơn hàng',
          style: AppTexts.appbarTitle,
        ),
        elevation: 0,
        backgroundColor: AppColors.themeColor,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 12,
                    ),
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
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTransactionStatus(
                                    transactionData.status)['title']!,
                                style: TextStyle(
                                  color: AppColors.themeColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                getTransactionStatus(
                                    transactionData.status)['subTitle']!,
                                style: TextStyle(
                                  color: AppColors.themeColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: FaIcon(
                              getIconData(transactionData.status),
                              color: AppColors.themeColor,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 12, bottom: 12),
                    margin: const EdgeInsets.only(bottom: 4),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeaderContent(
                          icon: Icons.delivery_dining_outlined,
                          title: 'Thông tin vận chuyển',
                        ),
                        BodyContent(
                          body: Row(
                            children: [
                              Text(
                                transactionData.transport,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                'đ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              Text(
                                Converter.convertNumberToMoney(
                                    transactionData.transportPrice),
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 24),
                        const HeaderContent(
                          icon: Icons.pin_drop_outlined,
                          title: 'Địa chỉ giao hàng',
                        ),
                        BodyContent(
                          body: Text(
                            transactionData.address,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.only(bottom: 4),
                    color: Colors.white,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: transactionData.products.length,
                      itemBuilder: (context, index) {
                        return TransactionProduct(
                          productData: transactionData.products[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey[400],
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Thành tiền',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'đ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              Converter.convertNumberToMoney(
                                  transactionData.totalPrice),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        transactionData.paid
                            ? RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Đơn hàng đã thanh toán ',
                                      style: TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'đ',
                                      style: TextStyle(
                                        color: AppColors.themeColor,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: Converter.convertNumberToMoney(
                                          transactionData.totalPrice),
                                      style: TextStyle(
                                        color: AppColors.themeColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' qua ZaloPay',
                                      style: TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Vui lòng thanh toán ',
                                      style: TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'đ',
                                      style: TextStyle(
                                        color: AppColors.themeColor,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: Converter.convertNumberToMoney(
                                          transactionData.totalPrice),
                                      style: TextStyle(
                                        color: AppColors.themeColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' khi nhận hàng',
                                      style: TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const HeaderContent(
                          icon: Icons.monetization_on_outlined,
                          title: 'Phương thức thanh toán',
                        ),
                        BodyContent(
                          body: Text(
                            transactionData.paymentMethod,
                            style: const TextStyle(
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mã đơn hàng',
                              style: AppTexts.text1.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              transactionData.id,
                              style: AppTexts.text2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Thời gian đặt hàng',
                              style: AppTexts.text1,
                            ),
                            Text(
                              Converter.convertDateToString(
                                  transactionData.dateCreated),
                              style: AppTexts.text2.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transactionData.status < 3
                                  ? 'Thời gian giao hàng (dự kiến)'
                                  : 'Thời gian hoàn thành',
                              style: AppTexts.text1,
                            ),
                            Text(
                              transactionData.status < 3
                                  ? Converter.convertDateToStringWithoutTime(
                                      transactionData.dateCompleted)
                                  : Converter.convertDateToString(
                                      transactionData.dateCompleted),
                              style: AppTexts.text2.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Lời nhắn',
                                style: AppTexts.text1,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 2,
                              child: Text(
                                '"${transactionData.note}"',
                                textAlign: TextAlign.end,
                                style: AppTexts.text2.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildAction(context),
        ],
      ),
    );
  }

  Widget buildAction(BuildContext context);

  Map<String, String> getTransactionStatus(int status) {
    switch (status) {
      case -1:
        return {
          'title': 'Đơn hàng đã hủy',
          'subTitle': 'Opps! Đơn hàng của bạn đã bị hủy'
        };
      case 0:
        return {
          'title': 'Đang chờ xác nhận',
          'subTitle': 'Đơn hàng của bạn đang trong quá trình chuẩn bị'
        };
      case 1:
        return {
          'title': 'Chờ lấy hàng',
          'subTitle':
              'Đơn hàng của bạn đang chờ để chuyển giao cho đơn vị vận chuyển'
        };
      case 2:
        return {
          'title': 'Chờ lấy hàng',
          'subTitle':
              'Đơn hàng của bạn đang chờ để chuyển giao cho đơn vị vận chuyển'
        };
      case 3:
        return {
          'title': 'Đang vận chuyển',
          'subTitle': 'Đơn hàng của bạn đang trên đường đến với bạn'
        };
      case 4:
        return {
          'title': 'Đơn hàng đã hoàn thành',
          'subTitle': 'Cảm ơn bạn đã mua sắm tại IBOO!'
        };
      default:
        return {'title': '', 'subTitle': ''};
    }
  }

  IconData getIconData(int status) {
    switch (status) {
      case -1:
        return FontAwesomeIcons.ban;
      case 0:
        return FontAwesomeIcons.envelopeOpenText;
      case 1:
        return FontAwesomeIcons.boxesPacking;
      case 2:
        return FontAwesomeIcons.boxesPacking;
      case 3:
        return FontAwesomeIcons.truckFast;
      case 4:
        return FontAwesomeIcons.peopleCarryBox;
      default:
        return Icons.error;
    }
  }
}
