import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/core/models/payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMethodListPage extends StatefulWidget {
  final List<PaymentMethodModel> payments;
  final PaymentMethodModel? selectedPayment;
  final void Function(PaymentMethodModel newPayment) onFinished;

  const PaymentMethodListPage({
    super.key,
    required this.payments,
    required this.onFinished,
    this.selectedPayment,
  });

  @override
  State<PaymentMethodListPage> createState() => _PaymentMethodListPageState();
}

class _PaymentMethodListPageState extends State<PaymentMethodListPage> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.selectedPayment != null) {
      selectedIndex = widget.payments.indexOf(widget.selectedPayment!);
    } else {
      selectedIndex = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Phương thức thanh toán',
          style: AppTexts.appbarTitle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.themeColor,
        foregroundColor: AppColors.contentColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 4,
            width: 10,
            color: Colors.transparent,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   selectedIndex = index;
                    // });
                  },
                  child: Container(
                    height: 64,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 64,
                          width: 4,
                          color: selectedIndex == index
                              ? AppColors.themeColor
                              : Colors.grey,
                          margin: const EdgeInsets.only(right: 12),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: widget.payments[index].image == ''
                              ? FaIcon(
                                  FontAwesomeIcons.peopleCarryBox,
                                  color: selectedIndex == index
                                      ? AppColors.themeColor
                                      : Colors.grey,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.phone_android,
                                  color: selectedIndex == index
                                      ? AppColors.themeColor
                                      : Colors.grey,
                                  size: 24,
                                ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Text(
                                  widget.payments[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                widget.payments[index].image != ''
                                    ? Image.asset(
                                        widget.payments[index].image,
                                        height: 20,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.check,
                            color: selectedIndex == index
                                ? AppColors.themeColor
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                  thickness: 2,
                );
              },
              itemCount: widget.payments.length,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedIndex >= 0) {
                    widget.onFinished(widget.payments[selectedIndex]);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Xác nhận',
                  style: AppTexts.buttonContent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
