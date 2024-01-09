import 'package:book_store/app_themes/app_colors.dart';
import 'package:book_store/app_themes/app_text.dart';
import 'package:book_store/core/models/transport_model.dart';
import 'package:book_store/utils/convert.dart';
import 'package:flutter/material.dart';

class TransportListPage extends StatefulWidget {
  final List<TransportModel> transports;
  final TransportModel? selectedTransport;
  final void Function(TransportModel list) onFinished;

  const TransportListPage({
    super.key,
    required this.transports,
    required this.onFinished,
    this.selectedTransport,
  });

  @override
  State<TransportListPage> createState() => _TransportListPageState();
}

class _TransportListPageState extends State<TransportListPage> {
  late int indexSelected;

  @override
  void initState() {
    super.initState();
    if (widget.selectedTransport != null) {
      indexSelected = widget.transports.indexOf(widget.selectedTransport!);
    } else {
      indexSelected = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Phương thức vận chuyển',
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            color: Colors.grey[200],
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Các phương thức vận chuyển của IBOO',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Image.asset(
                      'images/logo_fill_crop.png',
                      fit: BoxFit.contain,
                      height: 20,
                    ),
                  ],
                ),
                const Text(
                  'Bạn có thể theo dõi đơn hàng trên ứng dụng IBOO khi chọn một trong các đơn vị vận chuyển:',
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      indexSelected = index;
                    });
                  },
                  child: Container(
                    // height: 64,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 64,
                          width: 4,
                          color: indexSelected == index
                              ? AppColors.themeColor
                              : Colors.grey,
                          margin: const EdgeInsets.only(right: 12),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.transports[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              indexSelected == index ? 16 : 15,
                                          color: indexSelected == index
                                              ? Colors.black
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      'đ',
                                      style: TextStyle(
                                        color: indexSelected == index
                                            ? AppColors.themeColor
                                            : Colors.grey,
                                        decorationColor: indexSelected == index
                                            ? AppColors.themeColor
                                            : Colors.grey,
                                        fontSize:
                                            indexSelected == index ? 16 : 15,
                                        fontWeight: indexSelected == index
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        Converter.convertNumberToMoney(
                                            widget.transports[index].price),
                                        style: TextStyle(
                                          color: indexSelected == index
                                              ? AppColors.themeColor
                                              : Colors.grey,
                                          fontSize:
                                              indexSelected == index ? 16 : 15,
                                          fontWeight: indexSelected == index
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Nhận hàng sau ${widget.transports[index].min}-${widget.transports[index].max} ngày',
                                  style: TextStyle(
                                    color: indexSelected == index
                                        ? Colors.black
                                        : Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.check,
                            color: indexSelected == index
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
                  thickness: 1,
                );
              },
              itemCount: widget.transports.length,
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
                  if (indexSelected >= 0) {
                    widget.onFinished(widget.transports[indexSelected]);
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
